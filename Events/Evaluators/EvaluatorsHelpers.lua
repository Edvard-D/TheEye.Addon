local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
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
        TheEyeAddon.Events.Coordinator:RegisterEvaluator(evaluator)
    end
end

local function IncreaseValueGroupListenerCount(evaluator, valueGroup, listener)
    if valueGroup.listenerCount == nil then 
        valueGroup.listenerCount = 0
    end
    valueGroup.listenerCount = valueGroup.listenerCount + 1
    if valueGroup.listenerCount == 1 then -- If listenerCount was 0 before
        if evaluator.SetupListeningTo ~= nil then
            evaluator:SetupListeningTo(valueGroup, listener.inputValues)
        end

        if evaluator.CalculateCurrentState ~= nil then
            valueGroup.currentState = evaluator:CalculateCurrentState(listener.inputValues)
        end
        
        if evaluator.hasSavedValues == true then
            valueGroup.savedValues = {}
        end
    end
end

local function DecreaseEvaluatorListenerCount(evaluator)
    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    end
end

local function UnregisterValueGroupListeningTo(listeningTo)
    for i,listener in ipairs(listeningTo) do
        TheEyeAddon.Events.Evaluators:UnregisterListener(listener.listeningToKey, listener)
    end
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

    listener.OnStateChange = TheEyeAddon.Events.Evaluators.OnStateChange
    table.insert(valueGroup.ListeningTo, listener)
    
    TheEyeAddon.Events.Evaluators:RegisterListener(listener.listeningToKey, listener)
end

function TheEyeAddon.Events.Evaluators:OnStateChange(newState)
    TheEyeAddon.Events.Evaluators:EvaluateState(self.evaluator, self.listeningToKey, self.inputValues, newState)
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
        listener:OnStateChange(true)
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

function TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, event, ...)
    local valueGroupKey = evaluator:GetKey(event, ...)
    local valueGroup = evaluator.ValueGroups[valueGroupKey]
    if valueGroup ~= nil then
        local evaluatedState = evaluator:Evaluate(valueGroup.savedValues, event, ...)
        if evaluatedState ~= valueGroup.currentState then
            valueGroup.currentState = evaluatedState
            TheEyeAddon.Events.Evaluators:NotifyListeners(valueGroup.listeners, evaluatedState)
        end
    end
end

function TheEyeAddon.Events.Evaluators:NotifyListeners(listeners, newState)
    for i,listener in ipairs(listeners) do
        listener:OnStateChange(newState)
    end
end