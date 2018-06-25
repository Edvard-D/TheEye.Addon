local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects = {}

local table = table
local unpack = unpack


function TheEyeAddon.UI.Objects:Add(uiObject)
    TheEyeAddon.UI.Objects[table.concat(unpack(uiObject.tags))] = uiObject
end