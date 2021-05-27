TheEye.Core.UI.Components.CastSoonAlert = {}
local this = TheEye.Core.UI.Components.CastSoonAlert
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local auraFilters = TheEye.Core.Data.auraFilters
local CooldownClaim = TheEye.Core.UI.Factories.Cooldown.Claim
local EvaluatorListenerDeregister = TheEye.Core.Managers.Evaluators.ListenerDeregister
local EvaluatorListenerRegister = TheEye.Core.Managers.Evaluators.ListenerRegister
local GetPropertiesOfType = TheEye.Core.Managers.Icons.GetPropertiesOfType
local GetTime = GetTime
local IconsGetFiltered = TheEye.Core.Managers.Icons.GetFiltered
local math = math
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
        instance.isPeriodicDamage = true
        local AURA_APPLIED, _ = GetPropertiesOfType(iconData, "AURA_APPLIED", instance.spellID)
        local pandemicWindowMax = AURA_APPLIED.duration * 0.3
        instance.initialDuration = pandemicWindowMax
        instance.ListenerGroup.Listeners[1].comparisonValues.ceiling = pandemicWindowMax

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

local function ListenerGroupsSetup(self, spellID)
    local inputValues = nil
    if self.isPeriodicDamage == true then
        inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] spellID }
    else
        inputValues = { --[[spellID]] spellID }
    end

    self.DurationListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = self.ListenerGroup.Listeners[1].eventEvaluatorKey,
                inputValues = inputValues,
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

local function PeriodicDamageInitialDurationGet(self)
    local AURA_APPLIED, propertyCount = GetPropertiesOfType(self.UIObject.IconData, "AURA_APPLIED")

    if propertyCount == 1 then
        return self.spellID, GetTime(), self.initialDuration, self.initialDuration
    else
        local shortestRemainingTime = math.huge
        local shortestRemainingTimeSpellID = nil

        for i = 1, #AURA_APPLIED do
            local property = AURA_APPLIED[i]
            
            if property.requirement == nil
                or (property.requirement.type == "TALENT_REQUIRED" and select(10, GetTalentInfoByID(property.requirement.value, 1)) == true) 
                then
                local remainingTime = TheEye.Core.Helpers.Auras.UnitAuraDurationGet("player", "target", property.value)
                
                if remainingTime < shortestRemainingTime then
                    shortestRemainingTime = remainingTime
                    shortestRemainingTimeSpellID = property.value
                end
            end
        end

        local startTime = 0
        local duration = 0
        if shortestRemainingTimeSpellID == self.spellID then
            startTime = GetTime()
            duration = self.initialDuration
        else
            local icons = IconsGetFiltered(
                {
                    {
                        {
                            type = "OBJECT_ID",
                            value = shortestRemainingTimeSpellID,
                        },
                    },
                })
            
            AURA_APPLIED, _ = GetPropertiesOfType(icons[1], "AURA_APPLIED")
            pandemicWindowMax = AURA_APPLIED.duration * 0.3
            startTime = (GetTime() + shortestRemainingTime) - pandemicWindowMax
            duration = pandemicWindowMax
        end

        return shortestRemainingTimeSpellID, startTime, duration, shortestRemainingTime
    end
end

function this:Modify(frame)
    frame.cooldown = CooldownClaim(self.UIObject, frame, nil)
    frame.cooldown:SetAllPoints()
    frame.cooldown:SetDrawBling(false)
    frame.cooldown:SetDrawEdge(false)
    self.instance = frame.cooldown

    local spellID = self.spellID
    local remainingTime = 0

    if self.isPeriodicDamage == true then
        spellID, self.startTime, self.duration, remainingTime = PeriodicDamageInitialDurationGet(self)
    else
        self.startTime = GetTime()
        self.duration = this.DefaultAlertLengthGet()
        remainingTime = self.duration
    end

    self.previousEndTime = self.startTime + self.duration

    ListenerGroupsSetup(self, spellID)
    self:OnDurationChangedNotify(nil, remainingTime)
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

    if currentEndTime ~= self.previousEndTime then
        self.startTime = currentEndTime - self.duration
    end

    self.instance:SetCooldown(self.startTime, self.duration)
    self.previousEndTime = currentEndTime
end