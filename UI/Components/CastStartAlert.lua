TheEyeAddon.UI.Components.CastStartAlert = {}
local this = TheEyeAddon.UI.Components.CastStartAlert
local inherited = TheEyeAddon.UI.Components.FrameModifier

local castStartHideDelay = 0.5
local GetNetStats = GetNetStats
local select = select


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
]]
function this.Setup(
    instance
)

    instance.ValueHandler = { validKeys = { [2] = true, } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED",
                inputValues = { --[[unit]] "player", --[[spellID]] instance.spellID },
                comparisonValues =
                {
                    value = this.AlertLengthGet,
                    type = "LessThan",
                },
                value = 2,
            },
        },
    }

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        "background",
        "changer"
    )
end


function this:Modify(frame)
    frame.background:SetDesaturated(1)
end

function this:Demodify(frame)
    frame.background:SetDesaturated(nil)
end

function this.AlertLengthGet()
    return castStartHideDelay + select(4, GetNetStats()) / 1000
end