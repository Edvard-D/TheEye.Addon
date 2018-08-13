TheEyeAddon.UI.Components.CastStartAlert = {}
local this = TheEyeAddon.UI.Components.CastStartAlert
this.name = "CastStartAlert"
local inherited = TheEyeAddon.UI.Components.FrameModifier


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = nil
    ListenerGroup = nil
    spellID = #SPELL#ID#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    instance.ValueHandler = { validKeys = { [2] = true } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED",
                inputValues = { --[[spellID]] instance.spellID },
                comparisonValues =
                {
                    value = TheEyeAddon.Values.castStartHideDelay,
                    type = "LessThan",
                },
                value = 2,
            },
        },
    }

    instance.name = this.name
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        uiObject
    )
end


function this:Modify(frame)
    if self.frame == nil then
        frame.texture:SetDesaturated(1)
        -- @TODO Display model
    end
end

function this:Demodify()
    if self.frame ~= nil then
        frame.texture:SetDesaturated(nil)
        -- @TODO Destroy model
    end
end