local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects = {}

local table = table
local unpack = unpack


function TheEyeAddon.UI.Objects:Add(uiObject)
    local key = table.concat(uiObject.tags, "-")
    uiObject.key = key
    TheEyeAddon.UI.Objects[key] = uiObject
end