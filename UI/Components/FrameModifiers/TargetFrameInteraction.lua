TheEye.Core.UI.Components.TargetFrameInteraction = {}
local this = TheEye.Core.UI.Components.TargetFrameInteraction
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local healthChangePerSecondLookbackDuration = 30 -- seconds
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local TargetFrameClaim = TheEye.Core.UI.Factories.TargetFrame.Claim


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    unitGUID = #UNIT#GUID#
    auraSpellIDs = { #SPELL#ID# }
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.RaidMarkerSet = this.RaidMarkerSet
    instance.HealthSet = this.HealthSet
    instance.ChallengeSet = this.ChallengeSet
    instance.NameSet = this.NameSet
    instance.AuraSet = this.AuraSet
    instance.IsBossSet = this.IsBossSet
    instance.OnHealthChangePerSecondNotify = this.OnHealthChangePerSecondNotify

    instance.ValueHandler = { validKeys = { [0] = true, } }
    inherited.Setup(
        instance,
        "targetFrame",
        "creator"
    )
end

local function HealthChangePerSecondListenerGroupSetup(self)
    if self.HealthChangePerSecondListenerGroup ~= nil and self.HealthChangePerSecondListenerGroup.isActive == true then
        return
    end

    self.HealthChangePerSecondListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_HEALTH_CHANGE_PER_SECOND_CHANGED",
                inputValues = { --[[unitGUID]] self.unitGUID, --[[lookbackDuration]] healthChangePerSecondLookbackDuration },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.HealthChangePerSecondListenerGroup,
        self,
        "OnHealthChangePerSecondNotify"
    )

    if self.isBoss == true then
        self.HealthChangePerSecondListenerGroup:Activate()
    end
end

function this:Modify(frame)
    frame.targetFrame = TargetFrameClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, "INTERACTION", self.auraSpellIDs)
    self.targetFrame = frame.targetFrame
end

function this:Demodify(frame)
    frame.targetFrame:Release()
    self.targetFrame = nil
    self.health = nil
    self.healthChangePerSecond = nil
    if self.HealthChangePerSecondListenerGroup ~= nil then
        self.HealthChangePerSecondListenerGroup:Deactivate()
    end
end

local function TimeUntilDeathSet(self)
    if self.targetFrame ~= nil and self.health ~= nil and self.healthChangePerSecond ~= nil then
        self.targetFrame:TimeUntilDeathSet(self.health, self.healthChangePerSecond)
    end
end

function this:RaidMarkerSet(raidTargetIndex)
    if self.targetFrame ~= nil then
        self.targetFrame:RaidMarkerSet(raidTargetIndex)
    end
end

function this:HealthSet(health, healthMax)
    self.health = health
    TimeUntilDeathSet(self)

    if self.targetFrame ~= nil then
        self.targetFrame:HealthSet(health / healthMax)
    end
end

function this:ChallengeSet(classification, targetLevel, playerLevel, targetReaction, isPlayer, faction)
    if self.targetFrame ~= nil then
        self.targetFrame:ChallengeSet(classification, targetLevel, playerLevel, targetReaction, isPlayer, faction)
    end
end

function this:NameSet(value)
    if self.targetFrame ~= nil then
        self.targetFrame:NameSet(value)
    end
end

function this:AuraSet(spellID, isVisible)
    if self.targetFrame ~= nil then
        self.targetFrame:AuraSet(spellID, isVisible)
    end
end

function this:IsBossSet(value)
    if self.isBoss ~= value then
        self.isBoss = value

        if self.isBoss == true then
            HealthChangePerSecondListenerGroupSetup(self)
        elseif self.HealthChangePerSecondListenerGroup ~= nil then
            self.HealthChangePerSecondListenerGroup:Deactivate()
        end
    end

    if self.targetFrame ~= nil then
        self.targetFrame:IsBossSet(value)
    end
end

function this:OnHealthChangePerSecondNotify(event, value)
    self.healthChangePerSecond = value
    TimeUntilDeathSet(self)
end