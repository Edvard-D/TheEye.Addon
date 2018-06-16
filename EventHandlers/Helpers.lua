local TheEyeAddon = TheEyeAddon


local next = next


local function RegisterToEvents(eventHandler)
    if eventHandler.frame == nil then
        eventHandler.frame = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", nil, UIParent)
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

    if eventHandler.Comparisons[comparison] == nil then
        eventHandler.Comparisons[comparison] = {}
    end
    return eventHandler.Comparisons[comparison]
end

local function GetValueListeners(eventHandler, comparison, value)
    local values = GetComparisonValues(eventHandler, comparison)

    if values[value] == nil then
        values[value] = {}
    end
    return values[value]
end


function TheEyeAddon.EventHandlers:RegisterListener(eventHandler, listener)
    local listeners = GetValueListeners(eventHandler, listener.comparison, listener.validValue)

    if table.hasvalue(listeners, listener) == false then
        table.insert(listeners, listener)

        eventHandler.listenerCount = eventHandler.listenerCount + 1
        if eventHandler.listenerCount == 1 then -- If the value was 0 before
            RegisterToEvents(eventHandler)
        end
    else
        error("Trying to add a duplicate listener to an event handler.")
    end
end

function TheEyeAddon.EventHandlers:UnregisterListener(eventHandler, listener)
    local listeners = GetValueListeners(eventHandler, listener.comparison, listener.validValue)
    table.removevalue(listeners, listener)
    if next(listeners) == nil then -- This value has no listeners
        local values = GetComparisonValues(eventHandler, listener.comparison)
        table.removevalue(values, listener.validValue)
        if next(values) == nil then -- This comparison has no values
            table.removevalue(eventHandler.Comparisons, listener.comparison)
        end
    end

    eventHandler.listenerCount = eventHandler.listenerCount - 1
    if eventHandler.listenerCounter == 0 then -- If the value was greater than 0 before
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
        for comparison,values in pairs(eventHandler.Comparisons) do
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
        listener:OnStateChange(newState)
    end
end