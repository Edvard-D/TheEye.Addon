local TheEyeAddon = TheEyeAddon
local this = TheEyeAddon.Events.Evaluators

local CoordinatorRegister = TheEyeAddon.Events.Coordinator.Register
local CoordinatorUnregister = TheEyeAddon.Events.Coordinator.Unregister
local pairs = pairs
local select = select
local table = table


-- Get
local function InputGroupGet(evaluator, inputValues)
    if evaluator.InputGroups == nil then
        evaluator.InputGroups = {}
    end

    local inputGroupKey
    if inputValues ~= nil then
        inputGroupKey = table.concat(inputValues)
    else
        inputGroupKey = "default"
    end

    if evaluator.InputGroups[inputGroupKey] == nil then
        evaluator.InputGroups[inputGroupKey] = { key = inputGroupKey, Evaluator = evaluator }
    end
    
    return evaluator.InputGroups[inputGroupKey]
end

local function InputGroupGetComparisonGroup(inputGroup, comparisonValues)
    local comparisonGroupKey
    if comparisonValues ~= nil then
        comparisonGroupKey = table.concat(comparisonValues)
    else
        comparisonGroupKey = "default"
    end

    if inputGroup[comparisonKey] == nil then
        inputGroup[comparisonKey] = { comparisonValues = comparisonValues }
    end

    return inputGroup[comparisonKey]
end

local function ComparisonGroupGetListeners(comparisonGroup)
    if comparisonGroup.listeners == nil then
        comparisonGroup.listeners = {}
    end

    return comparisonGroup.listeners
end

-- Listener Count
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

local function InputGroupIncreaseListenerCount(evaluator, inputGroup, listener)
    if inputGroup.listenerCount == nil then
        inputGroup.listenerCount = 0
    end
    inputGroup.listenerCount = inputGroup.listenerCount + 1
    if inputGroup.listenerCount == 1 then -- If listenerCount was 0 before
        inputGroup.inputValues = listener.inputValues

        if evaluator.SetupListeningTo ~= nil then
            evaluator:SetupListeningTo(inputGroup)
        end

        if evaluator.CalculateCurrentState ~= nil then
            inputGroup.currentState = evaluator:CalculateCurrentState(listener.inputValues)
        end
    end
end

local function EvaluatorDecreaseListenerCount(evaluator)
    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        CoordinatorUnregister(evaluator)
    end
end

local function InputGroupDecreaseListenerCount(evaluator, inputGroup)
    inputGroup.listenerCount = inputGroup.listenerCount - 1
    if inputGroup.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        if inputGroup.ListeningTo ~= nil then
            InputGroupUnregisterListeningTo(inputGroup)
        end

        evaluator[inputGroup.key] = nil
    end
end

-- Register/Unregister
function this.ListenerRegister(evaluatorKey, listener)
    local evaluator = this[evaluatorKey] -- Key assigned during Evaluator declaration
    local inputGroup = InputGroupGet(evaluator, listener.inputValues)
    local comparisonGroup = InputGroupGetComparisonGroup(inputGroup, listener.comparisonValues)
    local listeners = ComparisonGroupGetListeners(comparisonGroup)
    
    table.insert(listeners, listener)
    EvaluatorIncreaseListenerCount(evaluator)
    InputGroupIncreaseListenerCount(evaluator, inputGroup, listener)

    if inputGroup.currentState == true then -- Set in InputGroupIncreaseListenerCount
        listener:Notify(evaluatorKey, true)
    end
end

local function InputGroupUnregisterListeningTo(inputGroup)
    local listeningTo = inputGroup.ListeningTo
    for i=1,#listeningTo do
        local listener = listeningTo[i]
        this.ListenerUnregister(listener.listeningToKey, listener)
    end
    inputGroup.ListeningTo = nil
end

function this.ListenerUnregister(evaluatorKey, listener)
    local evaluator = this[evaluatorKey]
    local inputGroup = InputGroupGet(evaluator, listener.inputValues)
    local comparisonGroup = InputGroupGetComparisonGroup(inputGroup, listener.comparisonValues)
    local listeners = ComparisonGroupGetListeners(comparisonGroup)

    table.removevalue(listeners, listener)
    EvaluatorDecreaseListenerCount(evaluator)
    InputGroupDecreaseListenerCount(evaluator, inputGroup)
end

-- Listening To: handling of Evaluators that are listening to an Evaluator
function this.InputGroupRegisterListeningTo(inputGroup, listener)
    if inputGroup.ListeningTo == nil then
        inputGroup.ListeningTo = {}
    end

    listener.Notify = this.Notify
    listener.Evaluator = inputGroup.Evaluator
    table.insert(inputGroup.ListeningTo, listener)
    
    this.ListenerRegister(listener.listeningToKey, listener)
end

-- Event Evaluation
local function ListenersNotify(listeners, ...)
    for i=1,#listeners do
        listeners[i]:Notify(...)
    end
end

local function Evaluate(evaluator, inputGroup, event, ...)
    local evaluatedValues = { evaluator:Evaluate(inputGroup, event, ...) }
    local shouldSend = evaluatedValues[1]
    if shouldSend == true then
        table.remove(evaluatedValues, 1)
        ListenersNotify(inputGroup.listeners, unpack(evaluatedValues))
    end
end

function this:Notify(event, ...)
    self.evaluator:OnEvent(event, ...)
end

function this:OnEvent(event, ...)
    if self.reevaluateEvents ~= nil and self.reevaluateEvents[event] ~= nil then
        for k,inputGroup in pairs(self.InputGroups) do -- @TODO change this to an array with a lookup table
            Evaluate(self, inputGroup, event, ...)
        end
    else
        local inputGroupKey = self:GetKey(event, ...)
        local inputGroup = self.InputGroups[inputGroupKey]

        if inputGroup ~= nil then
            Evaluate(self, inputGroup, event, ...)
        end
    end
end