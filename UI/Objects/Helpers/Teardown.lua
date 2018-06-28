local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs


function TheEyeAddon.UI.Objects:TeardownGroup(group)
    for evaluatorName,v in pairs(group.ListeningTo) do
        local listener = group.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects:TeardownEventGroups(uiObject)
    if uiObject.EventGroups ~= nil then
        for i,eventGroup in ipairs(uiObject.EventGroups) do
            TeardownGroup(uiObject, eventGroup)
        end
    end
end