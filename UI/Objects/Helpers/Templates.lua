local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Templates = {}
local this = TheEyeAddon.UI.Templates
this.TaggedComponents = {}

local table = table


function this:ComponentAddToTag(tag, component)
    if this.TaggedComponents[tag] == nil then
        this.TaggedComponents[tag] = {}
    end

    table.insert(this.TaggedComponents[tag], component)
end