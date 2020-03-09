TheEye.Core.UI.Components.Cooldown = {}
local this = TheEye.Core.UI.Components.Cooldown
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local CooldownClaim = TheEye.Core.UI.Factories.Cooldown.Claim
local EventDeregister = TheEye.Core.Managers.Events.Deregister
local EventRegister = TheEye.Core.Managers.Events.Register
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FontTemplate = TheEye.Core.Data.FontTemplates.Icon.Cooldown
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
	instance.customEvents = { "UPDATE", }
    instance.OnEvent = this.OnEvent

    inherited.Setup(
        instance,
        "cooldown",
        "creator"
    )
end


function this:Modify(frame)
    frame.cooldown = CooldownClaim(self.UIObject, frame, nil)
    frame.cooldown:CooldownStart(self.spellID)

    frame.text = frame.text or FontStringCreate(frame)
    self.textInstance = frame.text
    self.textInstance:StyleSet("OVERLAY", FontTemplate, "CENTER")
    EventRegister(self)
end

function this:Demodify(frame)
    frame.cooldown:Release()
    frame.cooldown = nil

    frame.text:SetText(nil)
    self.textInstance = nil
    EventDeregister(self)
end

local function RemainingTimeGet(self)
    local startTime, duration = GetSpellCooldown(self.spellID)
    local remainingTime = (startTime + duration) - GetTime()

    if remainingTime < 0 then
        remainingTime = 0
    end

    return remainingTime
end

function this:SortValueGet()
    return RemainingTimeGet(self)
end

function this:OnEvent(event, value)
	local remainingTime = RemainingTimeGet(self)
    self.textInstance:SetText(math.floor(remainingTime + 0.5))
end