local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ListenerGroups = {}

local ipairs = ipairs
local pairs = pairs
local select = select
local table = table


-- Setup
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

function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, listenerGroup)
    SetupListeningTo(uiObject, listenerGroup, listenerGroup.ListeningTo, listenerGroup.OnEvaluate)
end

function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, groupType)
    for i,listenerGroup in ipairs(uiObject.ListenerGroups) do
        if listenerGroup.type == groupType then
            listenerGroup.uiObject = uiObject
            SetupListeningTo(uiObject, listenerGroup, listenerGroup.ListeningTo, listenerGroup.OnEvaluate)
        end
    end
end


-- Teardown
function TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroup(listenerGroup)
    for evaluatorName,v in pairs(listenerGroup.ListeningTo) do
        local listener = listenerGroup.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroupsOfType(uiObject, groupType)
    if uiObject.ListenerGroups ~= nil then
        for i,listenerGroup in ipairs(uiObject.ListenerGroups) do
            if listenerGroup.type == groupType then
                TeardownGroup(uiObject, listenerGroup)
            end
        end
    end
end


-- OnEvaluate: STATE
function TheEyeAddon.UI.Objects.ListenerGroups:ChangeValueByState(state)
    if state == true then
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value)
    else
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value * -1)
    end
end


--OnTeardown: STATE
function TheEyeAddon.UI.Objects.ListenerGroups:StateSetFalse()
    self:OnEvaluate(false)
end