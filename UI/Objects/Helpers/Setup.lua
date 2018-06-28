local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table


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


function SetupListener(uiObject, group, listener, evaluatorName, OnEvaluate)
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

function TheEyeAddon.UI.Objects:SetupStateGroup(uiObject, stateGroup)
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

function TheEyeAddon.UI.Objects:SetupEventGroups(uiObject)
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