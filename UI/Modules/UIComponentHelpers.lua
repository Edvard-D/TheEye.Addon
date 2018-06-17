local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Modules.UIComponentHelpers = {}


local function SetupListener(component, stateGroup, listener, eventHandlerName)
    listener.component = component
    listener.stateGroup = enabledGroup
    TheEyeAddon.EventHandlers:RegisterListener(eventHandlerName, listener)
end