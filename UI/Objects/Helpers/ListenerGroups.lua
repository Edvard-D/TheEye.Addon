local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ListenerGroups = {}

local pairs = pairs
local select = select
local table = table


-- @TODO implement multiple component setup/teardown, likley in managers
function TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, groupType)
    local listenerGroups = uiObject.ListenerGroups
    for i = 1, #listenerGroups do
        local listenerGroup = listenerGroups[i]
        if listenerGroup.type == groupType then
            TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, listenerGroup)
        end
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