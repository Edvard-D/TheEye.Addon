local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Templates = {}
local this = TheEyeAddon.UI.Templates
this.TaggedComponents = {}

local table = table
local TaggedComponents = this.TaggedComponents


function this.ComponentAddToTag(tag, component)
    if this.TaggedComponents[tag] == nil then
        this.TaggedComponents[tag] = {}
    end

    table.insert(this.TaggedComponents[tag], component)
end

function this.ComponentsAttachByTag(tag, uiObject)
    local componentsWithTag = TaggedComponents[tag]
    for i=1,#componentsWithTag do
        local component = componentsWithTag[i]
        uiObject[component.name] = uiObject[component.name] or {}
        component:Setup(uiObject[component.name], uiObject)
    end
end