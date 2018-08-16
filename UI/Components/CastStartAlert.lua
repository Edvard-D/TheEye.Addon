TheEyeAddon.UI.Components.CastStartAlert = {}
local this = TheEyeAddon.UI.Components.CastStartAlert
this.name = "CastStartAlert"
local inherited = TheEyeAddon.UI.Components.FrameModifier

local castStartHideDelay = 0.5


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
                inputValues = { --[[unit]] "player", --[[spellID]] instance.spellID },
                comparisonValues =
                {
                    value = castStartHideDelay,
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
    frame.texture:SetDesaturated(1)
    if self.frame == nil then
        -- @TODO Display model
    end
end

function this:Demodify(frame)
    frame.texture:SetDesaturated(nil)
    if self.frame ~= nil then
        -- @TODO Destroy model
    end
end