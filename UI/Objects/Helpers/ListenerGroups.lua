local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ListenerGroups = {}

local ipairs = ipairs
local pairs = pairs
local select = select
local table = table


-- Setup
function SetupListener(uiObject, listenerGroup, listener, evaluatorName)
    listener.uiObject = uiObject
    listener.listenerGroup = listenerGroup
    listener.OnEvaluate = listenerGroup.OnEvaluate
    listener.OnTeardown = listenerGroup.OnTeardown
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
    if listenerGroup.OnSetup ~= nil then
        listenerGroup:OnSetup()
    end
    
    SetupListeningTo(uiObject, listenerGroup)
end

function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, groupType)
    for i,listenerGroup in ipairs(uiObject.ListenerGroups) do
        if listenerGroup.type == groupType then
            listenerGroup.uiObject = uiObject
            SetupGroup(uiObject, listenerGroup)
        end
    end
end


-- Teardown
function TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroup(listenerGroup)
    for evaluatorName,v in pairs(listenerGroup.ListeningTo) do
        local listener = listenerGroup.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
        if listener.OnTeardown ~= nil then
            listener:OnTeardown()
        end
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


-- STATE
function TheEyeAddon.UI.Objects.ListenerGroups:ChangeValueByState(state)
    if state == true then
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value)
    else
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value * -1)
    end
end

function TheEyeAddon.UI.Objects.ListenerGroups:StateSetFalse()
    print ("YEP")
    self:OnEvaluate(false)
end