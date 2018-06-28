local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local select = select
local table = table

-- SETUP
local function GetValueGroup(evaluator, inputValues)
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

local function GetValueGroupListeners(valueGroup)
    if valueGroup.listeners == nil then
        valueGroup.listeners = {}
    end

    return valueGroup.listeners
end

local function IncreaseEvaluatorListenerCount(evaluator)
    if evaluator.listenerCount == nil then 
        evaluator.listenerCount = 0
    end
    evaluator.listenerCount = evaluator.listenerCount + 1
    if evaluator.listenerCount == 1 then -- If listenerCount was 0 before
        evaluator.OnEvent = TheEyeAddon.Events.Evaluators.OnEvent
        TheEyeAddon.Events.Coordinator:RegisterListener(evaluator)
    end
end

local function IncreaseValueGroupListenerCount(evaluator, valueGroup, listener)
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

local function DecreaseEvaluatorListenerCount(evaluator)
    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        TheEyeAddon.Events.Coordinator:UnregisterListener(evaluator)
    end
end

local function UnregisterValueGroupListeningTo(listeningTo)
    for i,listener in ipairs(listeningTo) do
        TheEyeAddon.Events.Evaluators:UnregisterListener(listener.listeningToKey, listener)
    end
    listeningTo = nil
end

local function DecreaseValueGroupListenerCount(evaluator, valueGroup)
    valueGroup.listenerCount = evaluator.listenerCount - 1
    if valueGroup.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        if valueGroup.ListeningTo ~= nil then
            UnregisterValueGroupListeningTo(valueGroup.ListeningTo)
        end

        table.removevalue(evaluator, valueGroup)
    end
end

-- LISTENING TO: handling of Evaluators that are listening to an Evaluator
function TheEyeAddon.Events.Evaluators:RegisterValueGroupListeningTo(valueGroup, listener)
    if valueGroup.ListeningTo == nil then
        valueGroup.ListeningTo = {}
    end

    listener.OnEvaluate = TheEyeAddon.Events.Evaluators.OnEventEvaluator
    listener.valueGroup = valueGroup
    table.insert(valueGroup.ListeningTo, listener)
    
    TheEyeAddon.Events.Evaluators:RegisterListener(listener.listeningToKey, listener)
end

function TheEyeAddon.Events.Evaluators:OnEventEvaluator(newState, event, ...)
    self.valueGroup.evaluator:OnEvent(event, ...)
end


-- LISTENERS: handling of Listeners that are listening to an Evaluator
function TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey] -- Key assigned during Evaluator declaration
    local valueGroup = GetValueGroup(evaluator, listener.inputValues)
    local listeners = GetValueGroupListeners(valueGroup)
    
    table.insert(listeners, listener)
    IncreaseEvaluatorListenerCount(evaluator)
    IncreaseValueGroupListenerCount(evaluator, valueGroup, listener)

    if valueGroup.currentState == true then -- Set in IncreaseValueGroupListenerCount
        listener:OnEvaluate(true)
    end
end

function TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey]
    local valueGroup = GetValueGroup(evaluator, listener.inputValues)
    local listeners = GetValueGroupListeners(valueGroup)

    table.removevalue(listeners, listener)
    DecreaseEvaluatorListenerCount(evaluator)
    DecreaseValueGroupListenerCount(evaluator, valueGroup)
end


-- EVENT EVALUATION
local function NotifyListeners(listeners, state, ...)
    for i,listener in ipairs(listeners) do
        listener:OnEvaluate(state, ...)
    end
end

local function EvaluateState(evaluator, valueGroup, event, ...)
    local evaluatedValues = { evaluator:Evaluate(valueGroup, event, ...) }
    local evaluatedState = evaluatedValues[1]
    
    if (evaluator.type == "EVENT" and evaluatedState == true) or evaluatedState ~= valueGroup.currentState then
        valueGroup.currentState = evaluatedState
        NotifyListeners(valueGroup.listeners, unpack(evaluatedValues))
    end
end

function TheEyeAddon.Events.Evaluators:OnEvent(event, ...)
    if self.reevaluateEvents ~= nil and self.reevaluateEvents[event] ~= nil then
        for k,valueGroup in pairs(self.ValueGroups) do
            EvaluateState(self, valueGroup, event, ...)
        end
    else
        local valueGroupKey = self:GetKey(event, ...)
        local valueGroup = self.ValueGroups[valueGroupKey]

        if valueGroup ~= nil then
            EvaluateState(self, valueGroup, event, ...)
        end
    end
end