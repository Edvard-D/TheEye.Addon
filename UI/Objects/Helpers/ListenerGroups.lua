local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ListenerGroups = {}

local pairs = pairs
local select = select
local table = table


-- Setup
function SetupListener(uiObject, listenerGroup, listener, evaluatorName)
    listener.UIObject = uiObject
    listener.listenerGroup = listenerGroup
    listener.OnEvaluate = listenerGroup.OnEvaluate
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end

local function SetupListeningTo(uiObject, listenerGroup)
    local listeningTo = listenerGroup.ListeningTo
    for evaluatorName,v in pairs(listeningTo) do
        local listener = listeningTo[evaluatorName]
        SetupListener(uiObject, listenerGroup, listener, evaluatorName)
    end
end

function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, listenerGroup)
    listenerGroup.UIObject = uiObject

    if listenerGroup.OnSetup ~= nil then -- Must be called before setting up listeners
        listenerGroup:OnSetup()
    end

    SetupListeningTo(uiObject, listenerGroup)
end

function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, groupType)
    local listenerGroups = uiObject.ListenerGroups
    for i = 1, #listenerGroups do
        local listenerGroup = listenerGroups[i]
        if listenerGroup.type == groupType then
            TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, listenerGroup)
        end
    end
end


-- Teardown
function TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroup(listenerGroup)
    if listenerGroup.OnTeardown ~= nil then
        listenerGroup:OnTeardown()
    end

    for evaluatorName,v in pairs(listenerGroup.ListeningTo) do
        local listener = listenerGroup.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroupsOfType(uiObject, groupType)
    if uiObject.ListenerGroups ~= nil then
        local listenerGroups = uiObject.ListenerGroups
        for i=1, #listenerGroups do
            if listenerGroups[i].type == groupType then
                TeardownGroup(uiObject, listenerGroups[i])
            end
        end
    end
end