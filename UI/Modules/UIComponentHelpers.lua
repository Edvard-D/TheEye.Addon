local TheEyeAddon = TheEyeAddon


local function SetupListener(module, component, stateGroup, listener, eventHandlerName)
    listener.module = module
    listener.component = component
    listener.stateGroup = enabledGroup
    TheEyeAddon.EventHandlers:RegisterListener(eventHandlerName, listener)
end

local function SetupStateGroup(module, component, stateGroup)
    for eventHandlerName,v in pairs(enabledGroup.StateListeners) do
        local listener = enabledGroup.StateListeners[eventHandlerName]
        SetupListener(module, component, stateGroup, listener, eventHandlerName)
    end
end

function TheEyeAddon.UI.Modules.Components:SetupComponent(module, component)
    SetupStateGroup(module, component, component.StateGroups.Enabled)
end

function TheEyeAddon.UI.Modules.Components:OnStateChange(stateListener, newState)
    local stateGroup = stateListener.stateGroup
    local previousState = stateGroup.currentState
    
    if newState == stateListener.validValue then
        stateGroup.stateKey = stateGroup.stateKey + stateListener.stateValue
    else
        stateGroup.stateKey = stateGroup.stateKey - stateListener.stateValue
    end

    if stateGroup.validKeys[stateGroup.stateKey] ~= nil then
        stateGroup.currentState = true
        if previousState == false or previousState == nil then
            stateGroup:OnValidKey()
        end
    else
        stateGroup.currentState = false
        if previousState == true or previousState == nil then
            stateGroup:OnInvalidKey()
        end
    end
end