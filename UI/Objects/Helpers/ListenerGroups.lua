local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ListenerGroups = {}


-- Setup
function SetupListener(uiObject, listenerGroup, listener, evaluatorName, OnEvaluate)
    listener.uiObject = uiObject
    listener.listenerGroup = listenerGroup
    listener.OnEvaluate = OnEvaluate
    TheEyeAddon.Events.Evaluators:RegisterListener(evaluatorName, listener)
end


-- OnEvaluate: EVENT
function TheEyeAddon.UI.Objects.ListenerGroups:RegisterChild(event, uiObject)
    if self.uiObject.Children == nil then
        self.uiObject.Children = { uiObject }
    else
        table.insert(self.uiObject.Children, uiObject)
    end
end

function TheEyeAddon.UI.Objects.ListenerGroups:SortChildrenByPriority(state, event, uiObject)
    table.sort(uiObject.Children, function(a,b)
        return a.ListenerGroups.Priority.combinedKeyValue > b.ListenerGroups.Priority.combinedKeyValue end) 
end


-- OnEvaluate: STATE
function TheEyeAddon.UI.Objects.ListenerGroups:ChangeValueByState(state)
    if state == true then
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value)
    else
        self.uiObject.ValueHandlers[self.listenerGroup.valueHandlerKey]:ChangeValue(self.value * -1)
    end
end