TheEye.Core.UI.Components.CastSoonAlert = {}
local this = TheEye.Core.UI.Components.CastSoonAlert
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local auraFilters = TheEye.Core.Data.auraFilters
local CooldownClaim = TheEye.Core.UI.Factories.Cooldown.Claim
local GetPropertiesOfType = TheEye.Core.Managers.Icons.GetPropertiesOfType
local GetTime = GetTime
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup


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

    -- StateHandler
    instance.ValueHandler = { validKeys = { [2] = true } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                comparisonValues =
                {
                    floor = 0.001, -- Represents value of 0 but must be greater than 0
                    ceiling = this.DefaultAlertLengthGet,
                    type = "Between",
                },
                value = 2,
            },
        },
    }

    local iconData = TheEye.Core.Managers.UI.currentUIObject.IconData
    local CATEGORY = GetPropertiesOfType(iconData, "CATEGORY")

    if CATEGORY.value == "DAMAGE" and CATEGORY.subvalue == "PERIODIC" then
        local AURA_APPLIED, propertyCount = GetPropertiesOfType(iconData, "AURA_APPLIED", instance.spellID)
        local pandemicWindowMax = AURA_APPLIED.duration * 0.3
        instance.initialDuration = pandemicWindowMax
        instance.ListenerGroup.Listeners[1].comparisonValues.ceiling = instance.initialDuration

        instance.ListenerGroup.Listeners[1].eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED"
        instance.ListenerGroup.Listeners[1].inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] instance.spellID }
    else
        instance.ListenerGroup.Listeners[1].eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED"
        instance.ListenerGroup.Listeners[1].inputValues = { --[[spellID]] instance.spellID }
    end
    
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.OnDurationChangedNotify = this.OnDurationChangedNotify

    inherited.Setup(
        instance,
        "cooldown",
        "creator"
    )
end

local function ListenerGroupsSetup(self)
    self.DurationListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = self.ListenerGroup.Listeners[1].eventEvaluatorKey,
                inputValues = self.ListenerGroup.Listeners[1].inputValues,
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.DurationListenerGroup,
        self,
        "OnDurationChangedNotify"
    )
    self.DurationListenerGroup:Activate()
end

local function ListenerGroupsTeardown(self)
    self.DurationListenerGroup:Deactivate()
end

function this:Modify(frame)
    frame.cooldown = CooldownClaim(self.UIObject, frame, nil)
    frame.cooldown:SetAllPoints()
    frame.cooldown:SetDrawBling(false)
    frame.cooldown:SetDrawEdge(false)
    self.instance = frame.cooldown

    self.startTime = GetTime()
    self.duration = self.initialDuration
    if self.duration == nil then
        self.duration = this.DefaultAlertLengthGet()
    end
    self.previousEndTime = self.startTime + self.duration

    ListenerGroupsSetup(self)
    self:OnDurationChangedNotify(nil, self.duration)
end

function this:Demodify(frame)
    frame.cooldown:Release()
    frame.cooldown = nil
    ListenerGroupsTeardown(self)
end

function this.DefaultAlertLengthGet()
    local alertLength = 0.75
    local gcdLength = 1.5 / ((UnitSpellHaste("player") / 100) + 1)
    if gcdLength > alertLength then
        alertLength = gcdLength
    end

    return alertLength
end

function this:OnDurationChangedNotify(event, value)
    local currentEndTime = GetTime() + value
    if currentEndTime > self.previousEndTime then
        self.startTime = currentEndTime - self.duration
    end

    self.instance:SetCooldown(self.startTime, self.duration)
    self.previousEndTime = GetTime() + value
end