local TheEyeAddon = TheEyeAddon


local next = next


local function RegisterToEvents(eventHandler)
    if eventHandler.frame == nil then
        eventHandler.frame = TheEyeAddon.UI.Factories.Frame:Create("Frame", nil, UIParent)
        eventHandler.frame:SetScript("OnEvent", eventHandler.HandleEvent)
    end

    for k,v in pairs(eventHandler.registerTo) do
        eventHandler.frame:RegisterEvent(v)
    end
end

local function GetComparisonValues(eventHandler, comparison)
    if eventHandler.Comparisons == nil then
        eventHandler.Comparisons = {}
    end

    if eventHandler.Comparisons.comparison == nil then
        eventHandler.Comparisons.comparison = {}
    end
    return eventHandler.Comparisons.comparison
end

local function GetComparisonValueListeners(eventHandler, comparison, comparisonValue)
    local comparisonValues = GetComparisonValues(eventHandler, comparison)

    if comparisonValues.value == nil then
        comparisonValues.value = {}
    end
    return comparisonValues.value
end


function TheEyeAddon.EventHandlers:RegisterListener(eventHandlerKey, listener)
    local eventHandler = TheEyeAddon.EventHandlers[eventHandlerKey]
    local listeners = GetComparisonValueListeners(eventHandler, listener.comparison, listener.comparisonValue)

    if table.hasvalue(listeners, listener) == false then
        table.insert(listeners, listener)

        if eventHandler.listenerCount == nil then 
            eventHandler.listenerCount = 0
        end
        eventHandler.listenerCount = eventHandler.listenerCount + 1
        if eventHandler.listenerCount == 1 then -- If the comparisonValue was 0 before
            RegisterToEvents(eventHandler)
        end
    else
        error("Trying to add a duplicate listener to an event handler.")
    end
end

function TheEyeAddon.EventHandlers:UnregisterListener(eventHandlerKey, listener)
    local eventHandler = TheEyeAddon.EventHandlers[eventHandlerKey]
    local listeners = GetComparisonValueListeners(eventHandler, listener.comparison, listener.comparisonValue)
    table.removevalue(listeners, listener)
    if next(listeners) == nil then -- This comparisonValue has no listeners
        local comparisonValues = GetComparisonValues(eventHandler, listener.comparison)
        table.removevalue(values, listener.comparisonValue)
        if next(values) == nil then -- This comparison has no comparisonValues
            table.removevalue(eventHandler.Comparisons, listener.comparison)
        end
    end

    eventHandler.listenerCount = eventHandler.listenerCount - 1
    if eventHandler.listenerCounter == 0 then -- If the comparisonValue was greater than 0 before
        eventHandler.frame:UnregisterAllEvents()
        eventHandler.frame:SetScript("OnEvent", nil)
    elseif eventHandler.listenerCounter < 0 then
        error("Registered listeners set to " ..
            tostring(eventHandler.listenerCount) ..
            " but should never be below 0.")
    end
end

function TheEyeAddon.EventHandlers:EvaluateState(eventHandler, eventData)
    local evaluatedValue = eventHandler:Evaluate(eventData)
    if evaluatedValue ~= eventHandler.currentValue then        
        eventHandler.currentValue = evaluatedValue
        for comparison,comparisonValues in pairs(eventHandler.Comparisons) do
            for comparisonValue,listeners in pairs(values) do
                local evaluatedState = comparison(evaluatedValue, comparisonValue)
                if evaluatedState ~= comparisonValue.currentState then
                    comparisonValue.currentState = newState
                    TheEyeAddon.EventHandlers:NotifyListeners(listeners, evaluatedState)
                end
            end
        end
    end
end

function TheEyeAddon.EventHandlers:NotifyListeners(listeners, newState)
    for k,listener in pairs(listeners) do
        TheEyeAddon.UI.Modules.Components:OnStateChange(listener, newState)
    end
end