TheEye.Core.UI.Components.ElapsedTimeTracker = {}
local this = TheEye.Core.UI.Components.ElapsedTimeTracker
local inherited = TheEye.Core.UI.Elements.ValueHandlers.StaticValue

local GetTime = GetTime


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance
    )

    instance.SortValueGet = this.SortValueGet
    instance:Activate()
end

function this:SortValueGet()
    if self.value == nil then
        return 0
    else
        return GetTime() - self.value
    end
end