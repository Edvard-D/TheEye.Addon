local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table


function TheEyeAddon.UI.Objects:Add(uiObject) -- @TODO: rename to Register
    uiObject.DisplayData.uiObject = uiObject

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

function TheEyeAddon.UI.Objects:SetupStateGroup(uiObject, listenerGroup)
    listenerGroup.combinedKeyValue = 0
    listenerGroup.currentState = false
    
    if listenerGroup.ListeningTo ~= nil then
        SetupListeningTo(uiObject, listenerGroup, listenerGroup.ListeningTo, TheEyeAddon.UI.Objects.OnStateChange)
    end

    if listenerGroup.validKeys[listenerGroup.combinedKeyValue] == true then
        listenerGroup:OnValidKey(uiObject)
    end
end

local function SetupEventGroup(uiObject, eventGroup)
    SetupListeningTo(uiObject, eventGroup, eventGroup.ListeningTo, eventGroup.OnEvent)
end

function TheEyeAddon.UI.Objects:SetupEventGroups(uiObject)
    for i,group in ipairs(uiObject.ListenerGroups) do
        if group.type == "EVENT" then
            SetupEventGroup(uiObject, eventGroup)
        end
    end
end

function TheEyeAddon.UI.Objects:Initialize()
    local type = type
    for k,v in pairs(TheEyeAddon.UI.Objects) do
        if type(v) == "table" then
            SetupStateGroup(TheEyeAddon.UI.Objects[k], uiObject.ListenerGroups.Enabled)
        end
    end
end