local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs


function TheEyeAddon.UI.Objects:TeardownGroup(evaluatorGroup)
    for evaluatorName,v in pairs(evaluatorGroup.ListeningTo) do
        local listener = evaluatorGroup.ListeningTo[evaluatorName]
        TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
    end
end

function TheEyeAddon.UI.Objects:TeardownEventGroups(uiObject)
    if uiObject.ListenerGroups ~= nil then
        for i,eventGroup in ipairs(uiObject.ListenerGroups) do
            TeardownGroup(uiObject, eventGroup)
        end
    end
end