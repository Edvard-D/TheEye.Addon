local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table


function TheEyeAddon.UI.Objects:FormatData(uiObject)
    uiObject.DisplayData.uiObject = uiObject

    local key = table.concat(uiObject.tags, "_")
    uiObject.key = key
    TheEyeAddon.UI.Objects.Instances[key] = uiObject

    local searchableTags = {}
    for i,tag in ipairs(uiObject.tags) do
        searchableTags[tag] = true
    end
    uiObject.tags = searchableTags
end


function SetupListener(uiObject, listenerGroup, listener, evaluatorName, OnEvaluate)
    listener.uiObject = uiObject
    listener.listenerGroup = listenerGroup
    listener.OnEvaluate = OnEvaluate
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupListeningTo(uiObject, listenerGroup, listeningTo, OnEvaluate)
    for evaluatorName,v in pairs(listeningTo) do
        local listener = listenerGroup.ListeningTo[evaluatorName]
        SetupListener(uiObject, listenerGroup, listener, evaluatorName, OnEvaluate)
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

function TheEyeAddon.UI.Objects:SetupListenerGroupsOfType(uiObject, groupType)
    for i,listenerGroup in ipairs(uiObject.ListenerGroups) do
        if listenerGroup.type == groupType then
            SetupListeningTo(uiObject, listenerGroup, listenerGroup.ListeningTo, listenerGroup.OnEvent)
        end
    end
end

function TheEyeAddon.UI.Objects:Initialize()
    local type = type
    for k,uiObject in pairs(TheEyeAddon.UI.Objects.Instances) do
        print(tostring(uiObject.key))
        TheEyeAddon.UI.Objects:SetupStateGroup(uiObject, uiObject.ListenerGroups.Enabled)
    end
end