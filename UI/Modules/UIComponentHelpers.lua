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