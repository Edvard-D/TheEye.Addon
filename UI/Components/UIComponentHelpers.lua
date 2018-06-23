local TheEyeAddon = TheEyeAddon


-- SETUP/TEARDOWN
local function SetupListener(module, component, stateGroup, listener, evaluatorName)
    listener.module = module
    listener.component = component
    listener.stateGroup = stateGroup
    listener.OnStateChange = TheEyeAddon.UI.Components.OnStateChange
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupStateGroup(module, component, stateGroup)
    stateGroup.stateKey = 0
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        SetupListener(module, component, stateGroup, listener, evaluatorName)
    end
end

local function TeardownStateGroup(stateGroup)
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Components:SetupComponent(module, component)
    SetupStateGroup(module, component, component.StateGroups.Enabled)
end

function TheEyeAddon.UI.Components:TeardownComponent(component)
    for k,v in pairs(component.StateGroups) do
        TeardownStateGroup(component.StateGroups[k])
    end
end

-- STATE CHANGES
function TheEyeAddon.UI.Components:OnStateChange(stateListener, newState)
    local stateGroup = stateListener.stateGroup
    local previousState = stateGroup.currentState
    
    if newState == true then
        stateGroup.combinedKeyValues = stateGroup.combinedKeyValues + stateListener.keyValue
    else
        stateGroup.combinedKeyValues = stateGroup.combinedKeyValues - stateListener.keyValue
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValues] ~= nil then
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

function TheEyeAddon.UI.Components:EnableComponent(module, component)
    SetupStateGroup(module, component, component.StateGroups.Visible)
    TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_ENABLED_CHANGED", component, true)
end

function TheEyeAddon.UI.Components:DisableComponent(module, component)
    TeardownStateGroup(component.StateGroups.Visible)
    if component.StateGroups.Visible.currentState == true then
        TheEyeAddon.UI.Modules.Components:HideComponent(module, component)
    end
    TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_ENABLED_CHANGED", component, false)
end

function TheEyeAddon.UI.Components:ShowComponent(module, component)
    component.frame = component.DisplayData.factory:Claim(module.frame, component.DisplayData)
    module:OnComponentVisibleChanged()
    TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_VISIBILE_CHANGED", component, true)
end

function TheEyeAddon.UI.Components:HideComponent(module, component)
    component.frame:Release()
    component.frame = nil
    module:OnComponentVisibleChanged()
    TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_VISIBILE_CHANGED", component, false)
end