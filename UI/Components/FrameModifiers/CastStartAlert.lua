TheEyeAddon.UI.Components.CastStartAlert = {}
local this = TheEyeAddon.UI.Components.CastStartAlert
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local castStartHideDelay = 0.5
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local GetNetStats = GetNetStats
local IsIconValidForFilter = TheEyeAddon.Managers.Icons.IsIconValidForFilter
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


    local iconData = TheEyeAddon.Managers.UI.currentUIObject.IconData
    local isCastTypeCast = IsIconValidForFilter(iconData, { type = "CAST_TYPE", value = "CAST" })
    local isCastTypeChannel = IsIconValidForFilter(iconData, { type = "CAST_TYPE", value = "CHANNEL" })
    local COOLDOWN = GetPropertiesOfType(iconData, "COOLDOWN")
    local OBJECT_ID = GetPropertiesOfType(iconData, "OBJECT_ID")

    if isCastTypeCast == true or (isCastTypeChannel == true and COOLDOWN ~= nil) then
        instance.ValueHandler.validKeys[4] = true
        instance.ValueHandler.validKeys[6] = true

        instance.ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] instance.spellID },
                    value = 4,
                },
            },
        }
    end
    
    
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