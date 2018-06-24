local TheEyeAddon = TheEyeAddon


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
        evaluator.SetInitialState(evaluator, valueGroup, listener.inputValues)
    end
end

local function DecreaseEvaluatorListenerCount(evaluator)
    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCounter == 0 then -- If the listenerCounter was greater than 0 before
        TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    elseif evaluator.listenerCounter < 0 then -- DEBUG
        error("Evaluator listenerCount set to " ..
            tostring(evaluator.listenerCount) ..
            " but should never be below 0.")
    end
end

local function DecreaseValueGroupListenerCount(evaluator, valueGroup)
    valueGroup.listenerCount = evaluator.listenerCount - 1
    if valueGroup.listenerCounter == 0 then -- If the listenerCounter was greater than 0 before
        table.removevalue(evaluator, valueGroup)
    end
end


function TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey] -- Key assigned during Evaluator declaration
    local valueGroup = GetValueGroup(evaluator, inputValues)
    local listeners = GetValueGroupListeners(valueGroup)

    table.insert(listeners, listener)

    IncreaseEvaluatorListenerCount(evaluator)
    IncreaseValueGroupListenerCount(evaluator, valueGroup, listener)

    if valueGroup.currentState == true then
        TheEyeAddon.UI.Components:OnStateChange(listener, true)
    end
end

function TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey]
    local valueGroup = GetValueGroup(evaluator, inputValues)
    local listeners = GetValueGroupListeners(valueGroup)

    table.removevalue(listeners, listener)
    
    DecreaseEvaluatorListenerCount(evaluator)
    DecreaseValueGroupListenerCount(evaluator, valueGroup)
end

function TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, event, ...)
    local valueGroupKey, evaluatedState = evaluator:Evaluate(event, ...)
    local valueGroup = evaluator.ValueGroups[valueGroupKey]

    if valueGroup ~= nil and evaluatedState ~= valueGroup.currentState then
        print("Evaluators:EvaluateState ValueGroup    " .. valueGroupKey .. "    " .. tostring(evaluatedState)) -- DEBUG

        valueGroup.currentState = evaluatedState
        TheEyeAddon.Events.Evaluators:NotifyListeners(valueGroup.listeners, evaluatedState)
    end
end

function TheEyeAddon.Events.Evaluators:NotifyListeners(listeners, newState)
    for i,listener in ipairs(listeners) do
        TheEyeAddon.UI.Components:OnStateChange(listener, newState)
    end
end