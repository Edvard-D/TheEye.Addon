TheEye.Core.UI.Components.PriorityRank = {}
local this = TheEye.Core.UI.Components.PriorityRank
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender

local EnabledStateFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler =
    {
        validKeys =
        {
            [0] = #INT#
            #INT# = #INT#
        }
    }
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

    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        instance,
        2
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end

function this:SortValueGet()
    return self.ValueHandler.value
end