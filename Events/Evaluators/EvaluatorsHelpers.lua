local TheEyeAddon = TheEyeAddon
local this = TheEyeAddon.Events.Evaluators

local CoordinatorRegister = TheEyeAddon.Events.Coordinator.Register
local CoordinatorUnregister = TheEyeAddon.Events.Coordinator.Unregister
local pairs = pairs
local select = select
local table = table


-- SETUP
local function ValueGroupGet(evaluator, inputValues)
    if evaluator.ValueGroups == nil then
        evaluator.ValueGroups = {}
    end

    local valueGroupKey
    if inputValues ~= nil then
        valueGroupKey = table.concat(inputValues)
    else
        valueGroupKey = "default"
    end

    if evaluator.ValueGroups[valueGroupKey] == nil then
        evaluator.ValueGroups[valueGroupKey] = {}
        local valueGroup = evaluator.ValueGroups[valueGroupKey]
        valueGroup.key = valueGroupKey
        valueGroup.evaluator = evaluator
        return valueGroup
    end
    
    return evaluator.ValueGroups[valueGroupKey]
end

local function ValueGroupGetListeners(valueGroup)
    if valueGroup.listeners == nil then
        valueGroup.listeners = {}
    end

    return valueGroup.listeners
end

local function EvaluatorIncreaseListenerCount(evaluator)
    if evaluator.listenerCount == nil then 
        evaluator.listenerCount = 0
    end
    evaluator.listenerCount = evaluator.listenerCount + 1
    if evaluator.listenerCount == 1 then -- If listenerCount was 0 before
        evaluator.OnEvent = this.OnEvent
        CoordinatorRegister(evaluator)
    end
end

local function ValueGroupIncreaseListenerCount(evaluator, valueGroup, listener)
    if valueGroup.listenerCount == nil then
        valueGroup.listenerCount = 0
    end
    valueGroup.listenerCount = valueGroup.listenerCount + 1
    if valueGroup.listenerCount == 1 then -- If listenerCount was 0 before
        valueGroup.inputValues = listener.inputValues

        if evaluator.SetupListeningTo ~= nil then
            evaluator:SetupListeningTo(valueGroup)
        end

        if evaluator.CalculateCurrentState ~= nil then
            valueGroup.currentState = evaluator:CalculateCurrentState(listener.inputValues)
        end
    end
end

local function EvaluatorDecreaseListenerCount(evaluator)
    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        CoordinatorUnregister(evaluator)
    end
end

local function ValueGroupUnregisterListeningTo(listeningTo)
    for i=1,#listeningTo do
        local listener = listener[i]
        this:ListenerUnregister(listener.listeningToKey, listener)
    end
    listeningTo = nil
end

local function ValueGroupDecreaseListenerCount(evaluator, valueGroup)
    valueGroup.listenerCount = evaluator.listenerCount - 1
    if valueGroup.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        if valueGroup.ListeningTo ~= nil then
            ValueGroupUnregisterListeningTo(valueGroup.ListeningTo)
        end

        table.removevalue(evaluator, valueGroup)
    end
end

-- LISTENING TO: handling of Evaluators that are listening to an Evaluator
function this:ValueGroupRegisterListeningTo(valueGroup, listener)
    if valueGroup.ListeningTo == nil then
        valueGroup.ListeningTo = {}
    end

    listener.Notify = this.OnEventEvaluator
    listener.valueGroup = valueGroup
    table.insert(valueGroup.ListeningTo, listener)
    
    this:ListenerRegister(listener.listeningToKey, listener)
end

function this:OnEventEvaluator(newState, event, ...)
    self.valueGroup.evaluator:OnEvent(event, ...)
end


-- LISTENERS: handling of Listeners that are listening to an Evaluator
function this:ListenerRegister(evaluatorKey, listener)
    local evaluator = this[evaluatorKey] -- Key assigned during Evaluator declaration
    local valueGroup = ValueGroupGet(evaluator, listener.inputValues)
    local listeners = ValueGroupGetListeners(valueGroup)
    
    table.insert(listeners, listener)
    EvaluatorIncreaseListenerCount(evaluator)
    ValueGroupIncreaseListenerCount(evaluator, valueGroup, listener)

    if valueGroup.currentState == true then -- Set in ValueGroupIncreaseListenerCount
        listener:Notify(true)
    end
end

function this:ListenerUnregister(evaluatorKey, listener)
    local evaluator = this[evaluatorKey]
    local valueGroup = ValueGroupGet(evaluator, listener.inputValues)
    local listeners = ValueGroupGetListeners(valueGroup)

    table.removevalue(listeners, listener)
    EvaluatorDecreaseListenerCount(evaluator)
    ValueGroupDecreaseListenerCount(evaluator, valueGroup)
end


-- EVENT EVALUATION
local function ListenersNotify(listeners, message)
    for i=1,#listeners do
        listeners[i]:Notify(message)
    end
end

-- @TODO This differention shouldn't exist, the hierarchy of Evaluators generally
-- needs to be reworked.
local function EvaluateAsState(evaluator, valueGroup, event, ...)
    local evaluatedValues = { evaluator:Evaluate(valueGroup, event, ...) }
    local evaluatedState = evaluatedValues[1]
    if valueGroup.currentState ~= evaluatedState then
        valueGroup.currentState = evaluatedState
        ListenersNotify(valueGroup.listeners, unpack(evaluatedValues))
    end
end

local function EvaluateAsEvent(evaluator, valueGroup, event, ...)
    local evaluatedValues = { evaluator:Evaluate(valueGroup, event, ...) }
    local evaluatedState = evaluatedValues[1]
    if evaluatedState == true then
        evaluatedValues[1] = nil
        ListenersNotifyAsEvent(valueGroup.listeners, evaluator:Evaluate(valueGroup, event, unpack(evaluatedValues))) -- @TODO possibly have event data always packed in key table?
    end
end

local function Evaluate(evaluator, valueGroup, event, ...)
    if evaluator.type == "STATE" then
        EvaluateAsState(evaluator, valueGroup, event, ...)
    else
        EvaluateAsEvent(evaluator, valueGroup, event, ...)
    end
end

function this:Notify(event, ...)
    if self.reevaluateEvents ~= nil and self.reevaluateEvents[event] ~= nil then
        for k,valueGroup in pairs(self.ValueGroups) do -- @TODO change this to an array with a lookup table
            Evaluate(self, valueGroup, event, ...)
        end
    else
        local valueGroupKey = self:GetKey(event, ...)
        local valueGroup = self.ValueGroups[valueGroupKey]

        if valueGroup ~= nil then
            Evaluate(self, valueGroup, event, ...)
        end
    end
end