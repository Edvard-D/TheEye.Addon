local TheEyeAddon = TheEyeAddon


local function SetupListener(module, component, stateGroup, listener, eventHandlerName)
    listener.module = module
    listener.component = component
    listener.stateGroup = stateGroup
    listener.OnStateChange = TheEyeAddon.UI.Modules.Components.OnStateChange
    TheEyeAddon.EventHandlers:RegisterListener(eventHandlerName, listener)
end

local function SetupStateGroup(module, component, stateGroup)
    for eventHandlerName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[eventHandlerName]
        SetupListener(module, component, stateGroup, listener, eventHandlerName)
    end
end

local function TeardownStateGroup(stateGroup)
    for eventHandlerName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[eventHandlerName]
        TheEyeAddon.EventHandlers:RegisterListener(eventHandlerName, listener)
    end
end

function TheEyeAddon.UI.Modules.Components:SetupComponent(module, component)
    SetupStateGroup(module, component, component.StateGroups.Enabled)
end

function TheEyeAddon.UI.Modules.Components:OnStateChange(stateListener, newState)
    local stateGroup = stateListener.stateGroup
    local previousState = stateGroup.currentState
    
    if newState == true then
        stateGroup.stateKey = stateGroup.stateKey + stateListener.stateValue
    else
        stateGroup.stateKey = stateGroup.stateKey - stateListener.stateValue
    end

    if stateGroup.validKeys[stateGroup.stateKey] ~= nil then
        stateGroup.currentState = true
        if previousState == false or previousState == nil then
            stateGroup:OnValidKey(stateListener.module, stateListener.component)
        end
    else
        stateGroup.currentState = false
        if previousState == true or previousState == nil then
            stateGroup:OnInvalidKey(stateListener.module, stateListener.component)
        end
    end
end

function TheEyeAddon.UI.Modules.Components:EnableComponent(module, component)
    SetupStateGroup(module, component, self)
end