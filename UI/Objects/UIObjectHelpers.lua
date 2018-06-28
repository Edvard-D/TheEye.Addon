local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table
local unpack = unpack


function TheEyeAddon.UI.Objects:Add(uiObject)
    local key = table.concat(uiObject.tags, "_")
    uiObject.key = key
    TheEyeAddon.UI.Objects[key] = uiObject

    local searchableTags = {}
    for i,tag in ipairs(uiObject.tags) do
        searchableTags[tag] = true
    end
    uiObject.tags = searchableTags
end

-- SETUP
local function SetupListener(uiObject, group, listener, evaluatorName, OnEvaluate)
    listener.uiObject = uiObject
    listener.group = group
    listener.OnEvaluate = OnEvaluate
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupListeningTo(uiObject, group, listeningTo, OnEvaluate)
    for evaluatorName,v in pairs(listeningTo) do
        local listener = group.ListeningTo[evaluatorName]
        SetupListener(uiObject, group, listener, evaluatorName, OnEvaluate)
    end
end

local function SetupStateGroup(uiObject, stateGroup)
    stateGroup.combinedKeyValue = 0
    stateGroup.currentState = false
    
    if stateGroup.ListeningTo ~= nil then
        SetupListeningTo(uiObject, stateGroup, stateGroup.ListeningTo, TheEyeAddon.UI.Objects.OnStateChange)
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(uiObject)
    end
end

local function SetupEventGroup(uiObject, eventGroup)
    SetupListeningTo(uiObject, eventGroup, eventGroup.ListeningTo, eventGroup.OnEvent)
end

local function SetupEventGroups(uiObject)
    for k,eventGroup in pairs(uiObject.EventGroups) do
        SetupEventGroup(uiObject, eventGroup)
    end
end

local function Setup(uiObject)
    SetupStateGroup(uiObject, uiObject.StateGroups.Enabled)
end

function TheEyeAddon.UI.Objects:Initialize()
    for k,v in pairs(TheEyeAddon.UI.Objects) do
        if type(v) == "table" then
            Setup(TheEyeAddon.UI.Objects[k])
        end
    end
end

-- TEARDOWN
local function TeardownGroup(group)
    for evaluatorName,v in pairs(group.ListeningTo) do
        local listener = group.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

local function TeardownEventGroups(uiObject)
    if uiObject.EventGroups ~= nil then
        for k,eventGroup in pairs(uiObject.EventGroups) do
            TeardownGroup(uiObject, eventGroup)
        end
    end
end

local function Teardown(uiObject)
    for k,v in pairs(uiObject.StateGroups) do
        TeardownGroup(uiObject.StateGroups[k])
    end

    TeardownEventGroups(uiObject)
end

-- STATE CHANGES
function TheEyeAddon.UI.Objects:OnStateChange(newState)
    local stateGroup = self.stateGroup
    
    if newState == true then
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue + self.keyValue
    else
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue - self.keyValue
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(self.uiObject)
    else
        stateGroup:OnInvalidKey(self.uiObject)
    end
end

function TheEyeAddon.UI.Objects:Enable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= true then
        print ("ENABLE    " .. uiObject.key) -- DEBUG
        uiObject.StateGroups.Enabled.currentState = true

        SetupStateGroup(uiObject, uiObject.StateGroups.Visible)
        SetupEventGroups(uiObject)

        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Disable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= false then
        print ("DISABLE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Objects:Hide(uiObject)

        TeardownGroup(uiObject.StateGroups.Visible)
        TeardownEventGroups(uiObject)

        uiObject.StateGroups.Enabled.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Show(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= true then
        print ("SHOW    " .. uiObject.key) -- DEBUG
        uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject.DisplayData)
        uiObject.StateGroups.Visible.currentState = true
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Hide(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= false then
        print ("HIDE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Pools:Release(uiObject.frame)
        uiObject.frame = nil
        uiObject.StateGroups.Visible.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_HIDDEN", uiObject)
    end
end