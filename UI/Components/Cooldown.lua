TheEyeAddon.UI.Components.Cooldown = {}
local this = TheEyeAddon.UI.Components.Cooldown
this.name = "Cooldown"
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

    instance.name = this.name
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.SortValueGet = this.SortValueGet

    inherited.Setup(
        instance,
        uiObject
    )
end


function this:Modify(frame)
    if self.frame == nil then
        self.frame = CooldownClaim(self.UIObject, frame, nil)
        self.frame:SetAllPoints()
        self.frame:SetDrawBling(false)
        self.frame:SetDrawEdge(false)
        local startTime, duration = GetSpellCooldown(self.spellID)
        self.frame:SetCooldown(startTime, duration)
    end
end

function this:Demodify()
    if self.frame ~= nil then
        self.frame:Release()
        self.frame = nil
    end
end

function this:SortValueGet()
    local startTime, duration = GetSpellCooldown(self.spellID)
    local remainingTime = (startTime + duration) - GetTime()
    return remainingTime
end