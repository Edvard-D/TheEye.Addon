local TheEyeAddon = TheEyeAddon

local next = next


local function GetComparisonValues(evaluator, comparison)
    if evaluator.Comparisons == nil then
        evaluator.Comparisons = {}
    end

    if evaluator.Comparisons[comparison] == nil then
        evaluator.Comparisons[comparison] = {}
    end
    return evaluator.Comparisons[comparison]
end

local function GetComparisonValueListeners(evaluator, comparison, comparisonValue)
    local comparisonValues = GetComparisonValues(evaluator, comparison)

    if comparisonValues[comparisonValue] == nil then
        comparisonValues[comparisonValue] = {}
    end
    return comparisonValues[comparisonValue]
end


function TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey]
    local listeners = GetComparisonValueListeners(evaluator, listener.comparison, listener.comparisonValue)

    table.insert(listeners, listener)

    if evaluator.listenerCount == nil then 
        evaluator.listenerCount = 0
    end
    evaluator.listenerCount = evaluator.listenerCount + 1
    if evaluator.listenerCount == 1 then -- If the comparisonValue was 0 before
        TheEyeAddon.Events.Coordinator:RegisterEvaluator(evaluator)
    end
end

function TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorKey, listener)
    local evaluator = TheEyeAddon.Events.Evaluators[evaluatorKey]
    local listeners = GetComparisonValueListeners(evaluator, listener.comparison, listener.comparisonValue)
    table.removevalue(listeners, listener)
    if next(listeners) == nil then -- This comparisonValue has no listeners
        local comparisonValues = GetComparisonValues(evaluator, listener.comparison)
        table.removevalue(values, listener.comparisonValue)
        if next(values) == nil then -- This comparison has no comparisonValues
            table.removevalue(evaluator.Comparisons, listener.comparison)
        end
    end

    evaluator.listenerCount = evaluator.listenerCount - 1
    if evaluator.listenerCounter == 0 then -- If the comparisonValue was greater than 0 before
        TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    elseif evaluator.listenerCounter < 0 then
        error("Registered listeners set to " ..
            tostring(evaluator.listenerCount) ..
            " but should never be below 0.")
    end
end

function TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, eventData)
    local evaluatedValue = evaluator:Evaluate(eventData)
    if evaluatedValue ~= evaluator.currentValue then        
        evaluator.currentValue = evaluatedValue
        for comparison,comparisonValues in pairs(evaluator.Comparisons) do
            for comparisonValue,listeners in pairs(comparisonValues) do
                local evaluatedState = comparison(evaluatedValue, comparisonValue)
                if evaluatedState ~= comparisonValues[comparisonValue].currentState then
                    comparisonValues[comparisonValue].currentState = newState
                    TheEyeAddon.Events.Evaluators:NotifyListeners(listeners, evaluatedState)
                end
            end
        end
    end
end

function TheEyeAddon.Events.Evaluators:NotifyListeners(listeners, newState)
    for k,listener in pairs(listeners) do
        TheEyeAddon.UI.Components:OnStateChange(listener, newState)
    end
end