local TheEyeAddon = TheEyeAddon

local pairs = pairs


-- SETUP/TEARDOWN
local function SetupListener(module, component, stateGroup, listener, evaluatorName)
    listener.module = module
    listener.component = component
    listener.stateGroup = stateGroup
    listener.OnStateChange = TheEyeAddon.UI.Components.OnStateChange
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupStateGroup(module, component, stateGroup)
    stateGroup.combinedKeyValue = 0
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        SetupListener(module, component, stateGroup, listener, evaluatorName)
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(module, component)
    end
end

local function TeardownStateGroup(stateGroup)
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
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
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue + stateListener.keyValue
    else
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue - stateListener.keyValue
    end
    
    print("stateGroup.combinedKeyValue    " .. tostring(stateGroup.combinedKeyValue))

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(stateListener.module, stateListener.component)
    else
        stateGroup:OnInvalidKey(stateListener.module, stateListener.component)
    end
end

function TheEyeAddon.UI.Components:EnableComponent(module, component)
    print("EnableComponent")
    if component.StateGroups.Enabled.currentState ~= true then
        component.StateGroups.Enabled.currentState = true
        SetupStateGroup(module, component, component.StateGroups.Visible)
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_ENABLED_CHANGED", component, true)
    end
end

function TheEyeAddon.UI.Components:DisableComponent(module, component)
    print("DisableComponent")
    if component.StateGroups.Enabled.currentState ~= false then
        TheEyeAddon.UI.Components:HideComponent(module, component)
        TeardownStateGroup(component.StateGroups.Visible)

        component.StateGroups.Enabled.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_ENABLED_CHANGED", component, false)
    end
end

function TheEyeAddon.UI.Components:ShowComponent(module, component)
    print("ShowComponent")
    if component.StateGroups.Visible.currentState ~= true then
        component.frame = component.DisplayData.factory:Claim(module.frame, component.DisplayData)
        component.StateGroups.Visible.currentState = true
        module:OnComponentVisibleChanged()
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_VISIBILE_CHANGED", component, true)
    end
end

function TheEyeAddon.UI.Components:HideComponent(module, component)
    print("HideComponent")
    if component.StateGroups.Visible.currentState ~= false then
        component.frame:Release()
        component.frame = nil
        component.StateGroups.Visible.currentState = false
        module:OnComponentVisibleChanged()
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_COMPONENT_VISIBILE_CHANGED", component, false)
    end
end