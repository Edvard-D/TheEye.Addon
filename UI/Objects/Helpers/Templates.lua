local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Templates = {}
local this = TheEyeAddon.UI.Templates
this.TagComponents = {}

local table = table


function this:ComponentAdd(tag, component)
    if this.TagComponents[tag] == nil then
        this.TagComponents[tag] = {}
    end

    table.insert(this.TagComponents[tag], component)
end