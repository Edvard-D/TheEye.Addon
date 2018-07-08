local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Templates = {}
local this = TheEyeAddon.UI.Templates
this.TaggedComponents = {}

local table = table
local TaggedComponents = this.TaggedComponents


function this:ComponentAddToTag(tag, component)
    if this.TaggedComponents[tag] == nil then
        this.TaggedComponents[tag] = {}
    end

    table.insert(this.TaggedComponents[tag], component)
end

function this:ComponentsAttachByTag(tag, UIObject)
    for i=1,#TaggedComponents do
        local component = TaggedComponents[i]
        UIObject[component.name] = UIObject[component.name] or {}
        component:Setup(UIObject[component.name], UIObject)
    end
end