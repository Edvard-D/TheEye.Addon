local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Modules.UIComponentHelpers = {}


local function SetupListener(component, stateGroup, listener, eventHandlerName)
    listener.component = component
    listener.stateGroup = enabledGroup
    TheEyeAddon.EventHandlers:RegisterListener(eventHandlerName, listener)
end

local function SetupStateGroup(component, stateGroup)
    for eventHandlerName,v in pairs(enabledGroup.StateListeners) do
        local listener = enabledGroup.StateListeners[eventHandlerName]
        SetupListener(component, stateGroup, listener, eventHandlerName)
    end
end

function TheEyeAddon.UI.Modules.UIComponentHelpers:SetupComponent(module, component)
    SetupStateGroup(component, component.StateGroups.Enabled)
end