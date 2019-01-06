TheEyeAddon.UI.Elements.ValueHandlers.IntegerKeyValue = {}
local this = TheEyeAddon.UI.Elements.ValueHandlers.IntegerKeyValue
local inherited = TheEyeAddon.UI.Elements.ValueHandlers.KeyValue


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    validKeys = { #INT# = #VALUE# }
}
]]


--[[ #SETUP#
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance,
        this.Add,
        0
    )
end

function this:Add(value)
    return self[self.valueKey] + value
end