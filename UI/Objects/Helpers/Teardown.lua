local TheEyeAddon = TheEyeAddon

local pairs = pairs


function TheEyeAddon.UI.Objects:TeardownGroup(group)
    for evaluatorName,v in pairs(group.ListeningTo) do
        local listener = group.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects:TeardownEventGroups(uiObject)
    if uiObject.EventGroups ~= nil then
        for k,eventGroup in pairs(uiObject.EventGroups) do
            TeardownGroup(uiObject, eventGroup)
        end
    end
end