local TheEyeAddon = TheEyeAddon
local this = TheEyeAddon.Events.Evaluators

local Comparisons = TheEyeAddon.Comparisons
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
        evaluator.InputGroups[inputGroupKey] = { key = inputGroupKey, }
    end
    
    return evaluator.InputGroups[inputGroupKey]
end

local function InputGroupGetListeners(inputGroup)
    if inputGroup.listeners == nil then
        inputGroup.listeners = {}
    end

    return inputGroup.listeners
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
        inputGroup.Evaluator = inputGroup.Evaluator
        inputGroup.inputValues = listener.inputValues

        if evaluator.SetupListeningTo ~= nil then
            evaluator:SetupListeningTo(inputGroup)
        end

        if evaluator.CalculateCurrentValue ~= nil then
            inputGroup.currentValue = evaluator:CalculateCurrentValue(listener.inputValues)
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
            this.InputGroupUnregisterListeningTo(inputGroup)
        end

        evaluator[inputGroup.key] = nil
    end
end

-- Register/Unregister
function this.ListenerRegister(evaluatorKey, listener)
    local evaluator = this[evaluatorKey] -- Key assigned during Evaluator declaration
    local inputGroup = InputGroupGet(evaluator, listener.inputValues)
    local listeners = InputGroupGetListeners(inputGroup)
    
    print ("ListenerRegister evaluatorKey: " .. evaluatorKey) -- @DEBUG
    
    table.insert(listeners, listener)
    EvaluatorIncreaseListenerCount(evaluator)
    InputGroupIncreaseListenerCount(evaluator, inputGroup, listener)

    if listener.comparisonValues ~= nil then
        listener.comparisonState = this.Compare(listener.comparisonValues, inputGroup.currentValue)
    end

    if (listener.comparisonValues == nil and inputGroup.currentValue == true)
        or listener.comparisonState == true then
        listener:Notify(evaluatorKey, true)
    end
end

function this.InputGroupUnregisterListeningTo(inputGroup)
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
    local listeners = InputGroupGetListeners(inputGroup)

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
function this.Compare(comparisonValues, value)
    return Comparisons[comparisonValues.type](value, comparisonValues.value)
end

local function ListenerNotifyAsComparison(inputGroup, listener, event)
    local comparisonState = Compare(listener.comparisonValues, inputGroup.currentValue)
    if listener.comparisonState ~= comparisonState then
        listener.comparisonState = comparisonState
        listener:Notify(event, comparisonState)
    end
end

local function ListenersNotify(inputGroup, ...)
    local listeners = inputGroup.listeners
    for i=1,#listeners do
        local listener = listeners[i]
        
        if listener.comparisonValues ~= nil then
            ListenerNotifyAsComparison(inputGroup, listener, ...)
        else
            listener:Notify(...)
        end
    end
end

local function Evaluate(evaluator, inputGroup, event, ...)
    local evaluatedValues = { evaluator:Evaluate(inputGroup, event, ...) }
    local shouldSend = evaluatedValues[1]
    if shouldSend == true then
        table.remove(evaluatedValues, 1)
        ListenersNotify(inputGroup, unpack(evaluatedValues))
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