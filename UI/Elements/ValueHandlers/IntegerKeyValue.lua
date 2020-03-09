TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyValue = {}
local this = TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyValue
local inherited = TheEye.Core.UI.Elements.ValueHandlers.KeyValue


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