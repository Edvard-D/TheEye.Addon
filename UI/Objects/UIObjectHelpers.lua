local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table
local unpack = unpack


function TheEyeAddon.UI.Objects:Add(uiObject)
    local key = table.concat(uiObject.tags, "-")
    uiObject.key = key
    TheEyeAddon.UI.Objects[key] = uiObject

    local searchableTags = {}
    for i,tag in ipairs(tableName) do
        searchableTags[tag] = true
    end
    uiObject.tags = searchableTags
end

-- SETUP/TEARDOWN
local function SetupListener(uiObject, stateGroup, listener, evaluatorName)
    listener.uiObject = uiObject
    listener.stateGroup = stateGroup
    listener.OnStateChange = TheEyeAddon.UI.Objects.OnStateChange
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupStateGroup(uiObject, stateGroup)
    stateGroup.combinedKeyValue = 0
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        SetupListener(uiObject, stateGroup, listener, evaluatorName)
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(uiObject)
    end
end

local function TeardownStateGroup(stateGroup)
    for evaluatorName,v in pairs(stateGroup.StateListeners) do
        local listener = stateGroup.StateListeners[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects:Setup(uiObject)
    SetupStateGroup(uiObject, uiObject.StateGroups.Enabled)
end

function TheEyeAddon.UI.Objects:Teardown(uiObject)
    for k,v in pairs(uiObject.StateGroups) do
        TeardownStateGroup(uiObject.StateGroups[k])
    end
end

-- STATE CHANGES
function TheEyeAddon.UI.Objects:OnStateChange(stateListener, newState)
    local stateGroup = stateListener.stateGroup
    local previousState = stateGroup.currentState
    
    if newState == true then
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue + stateListener.keyValue
    else
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue - stateListener.keyValue
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(stateListener.uiObject)
    else
        stateGroup:OnInvalidKey(stateListener.uiObject)
    end
end

function TheEyeAddon.UI.Objects:Enable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= true then
        uiObject.StateGroups.Enabled.currentState = true
        SetupStateGroup(uiObject, uiObject.StateGroups.Visible)
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_UIOBJECT_ENABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Disable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= false then
        TheEyeAddon.UI.Objects:Hide(uiObject)
        TeardownStateGroup(uiObject.StateGroups.Visible)

        uiObject.StateGroups.Enabled.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_UIOBJECT_DISABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Show(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= true then
        uiObject.frame = uiObject.DisplayData.factory:Claim(module.frame, uiObject.DisplayData) --TODO: set parent
        uiObject.StateGroups.Visible.currentState = true
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_UIOBJECT_SHOWN", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Hide(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= false then
        uiObject.frame:Release()
        uiObject.frame = nil
        uiObject.StateGroups.Visible.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("THEEYE_UIOBJECT_HIDDEN", uiObject)
    end
end