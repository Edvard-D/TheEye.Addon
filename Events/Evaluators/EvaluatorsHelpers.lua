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

local function GetValueGroupListeners(evaluator, inputValues)
    local valueGroup = GetValueGroup(evaluator, inputValues)
    
    if valueGroup.listeners == nil then
        valueGroup.listeners = {}
    end

    return valueGroup.listeners
end


function TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey] -- Key assigned during Evaluator declaration
    local listeners = GetValueGroupListeners(evaluator, listener.inputValues)

    table.insert(listeners, listener)

    if evaluator.listenerCount == nil then 
        evaluator.listenerCount = 0
    end
    evaluator.listenerCount = evaluator.listenerCount + 1
    if evaluator.listenerCount == 1 then -- If listenerCount was 0 before
        TheEyeAddon.Events.Coordinator:RegisterEvaluator(evaluator)
    end
end

function TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey]
    local listeners = GetValueGroupListeners(evaluator, listener.inputValues)

    table.removevalue(listeners, listener)

    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCounter == 0 then -- If the listenerCounter was greater than 0 before
        TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    elseif evaluator.listenerCounter < 0 then -- DEBUG
        error("listenerCount set to " ..
            tostring(evaluator.listenerCount) ..
            " but should never be below 0.")
    end
end

function TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, eventName, ...)
    local key, evaluatedState = evaluator:Evaluate(eventName, ...)
    local valueGroup = evaluator.ValueGroups[key]

    if valueGroup ~= nil and evaluatedState ~= valueGroup.currentState then
        print("Evaluators:EvaluateState ValueGroup    " .. key .. "    " .. tostring(evaluatedState)) -- DEBUG

        valueGroup.currentState = evaluatedState
        TheEyeAddon.Events.Evaluators:NotifyListeners(valueGroup.listeners, evaluatedState)
    end
end

function TheEyeAddon.Events.Evaluators:NotifyListeners(listeners, newState)
    for i,listener in ipairs(listeners) do
        TheEyeAddon.UI.Components:OnStateChange(listener, newState)
    end
end