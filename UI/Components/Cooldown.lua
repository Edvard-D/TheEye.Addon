TheEyeAddon.UI.Components.Cooldown = {}
local this = TheEyeAddon.UI.Components.Cooldown
local inherited = TheEyeAddon.UI.Components.FrameModifier

local CooldownClaim = TheEyeAddon.UI.Factories.Cooldown.Claim
local GetSpellCooldown = GetSpellCooldown


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

    instance.ValueHandler = { validKeys = { [2] = true } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                inputValues = { --[[spellID]] instance.spellID },
                comparisonValues =
                {
                    value = 0,
                    type = "GreaterThan",
                },
                value = 2,
            },
        },
    }

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.SortValueGet = this.SortValueGet

    inherited.Setup(
        instance,
        "cooldown",
        "creator"
    )
end


function this:Modify(frame)
    frame.cooldown = CooldownClaim(self.UIObject, frame, nil)
    frame.cooldown:SetAllPoints()
    frame.cooldown:SetDrawBling(false)
    frame.cooldown:SetDrawEdge(false)
    local startTime, duration = GetSpellCooldown(self.spellID)
    frame.cooldown:SetCooldown(startTime, duration)
end

function this:Demodify(frame)
    frame.cooldown:Release()
    frame.cooldown = nil
end

function this:SortValueGet()
    local startTime, duration = GetSpellCooldown(self.spellID)
    local remainingTime = (startTime + duration) - GetTime()
    return remainingTime
end