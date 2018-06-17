local TheEyeAddon = TheEyeAddon


local next = next


local function RegisterToEvents(handler)
    if handler.frame == nil then
        handler.frame = TheEyeAddon.UI.Factories.Frame:Create("Frame", nil, UIParent)
        handler.frame:SetScript("OnEvent", handler.HandleEvent)
    end

    for k,v in pairs(handler.registerTo) do
        handler.frame:RegisterEvent(v)
    end
end

local function GetComparisonValues(handler, comparison)
    if handler.Comparisons == nil then
        handler.Comparisons = {}
    end

    if handler.Comparisons.comparison == nil then
        handler.Comparisons.comparison = {}
    end
    return handler.Comparisons.comparison
end

local function GetComparisonValueListeners(handler, comparison, comparisonValue)
    local comparisonValues = GetComparisonValues(handler, comparison)

    if comparisonValues.value == nil then
        comparisonValues.value = {}
    end
    return comparisonValues.value
end


function TheEyeAddon.Events.Handlers:RegisterListener(handlerKey, listener)
    local handler = TheEyeAddon.Events.Handlers[handlerKey]
    local listeners = GetComparisonValueListeners(handler, listener.comparison, listener.comparisonValue)

    if table.hasvalue(listeners, listener) == false then
        table.insert(listeners, listener)

        if handler.listenerCount == nil then 
            handler.listenerCount = 0
        end
        handler.listenerCount = handler.listenerCount + 1
        if handler.listenerCount == 1 then -- If the comparisonValue was 0 before
            RegisterToEvents(handler)
        end
    else
        error("Trying to add a duplicate listener to an event handler.")
    end
end

function TheEyeAddon.Events.Handlers:UnregisterListener(handlerKey, listener)
    local handler = TheEyeAddon.Events.Handlers[handlerKey]
    local listeners = GetComparisonValueListeners(handler, listener.comparison, listener.comparisonValue)
    table.removevalue(listeners, listener)
    if next(listeners) == nil then -- This comparisonValue has no listeners
        local comparisonValues = GetComparisonValues(handler, listener.comparison)
        table.removevalue(values, listener.comparisonValue)
        if next(values) == nil then -- This comparison has no comparisonValues
            table.removevalue(handler.Comparisons, listener.comparison)
        end
    end

    handler.listenerCount = handler.listenerCount - 1
    if handler.listenerCounter == 0 then -- If the comparisonValue was greater than 0 before
        handler.frame:UnregisterAllEvents()
        handler.frame:SetScript("OnEvent", nil)
    elseif handler.listenerCounter < 0 then
        error("Registered listeners set to " ..
            tostring(handler.listenerCount) ..
            " but should never be below 0.")
    end
end

function TheEyeAddon.Events.Handlers:EvaluateState(handler, eventData)
    local evaluatedValue = handler:Evaluate(eventData)
    if evaluatedValue ~= handler.currentValue then        
        handler.currentValue = evaluatedValue
        for comparison,comparisonValues in pairs(handler.Comparisons) do
            for comparisonValue,listeners in pairs(values) do
                local evaluatedState = comparison(evaluatedValue, comparisonValue)
                if evaluatedState ~= comparisonValue.currentState then
                    comparisonValue.currentState = newState
                    TheEyeAddon.Events.Handlers:NotifyListeners(listeners, evaluatedState)
                end
            end
        end
    end
end

function TheEyeAddon.Events.Handlers:NotifyListeners(listeners, newState)
    for k,listener in pairs(listeners) do
        TheEyeAddon.UI.Modules.Components:OnStateChange(listener, newState)
    end
end