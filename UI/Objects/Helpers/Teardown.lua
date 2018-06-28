local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs


function TheEyeAddon.UI.Objects:TeardownGroup(listenerGroup)
    for evaluatorName,v in pairs(listenerGroup.ListeningTo) do
        local listener = listenerGroup.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects:TeardownListenerGroupsOfType(uiObject, groupType)
    if uiObject.ListenerGroups ~= nil then
        for i,listenerGroup in ipairs(uiObject.ListenerGroups) do
            if listenerGroup.type == groupType then
                TeardownGroup(uiObject, listenerGroup)
            end
        end
    end
end