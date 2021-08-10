TheEye.Core.UI.Components.TargetFramePrimary = {}
local this = TheEye.Core.UI.Components.TargetFramePrimary
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local DoTSpellIDsGet = TheEye.Core.Managers.Icons.DoTSpellIDsGet
local EventsDeregister = TheEye.Core.Managers.Events.Deregister
local EventsRegister = TheEye.Core.Managers.Events.Register
local healthChangePerSecondLookbackDuration = 30 -- seconds
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table
local TargetFrameClaim = TheEye.Core.UI.Factories.TargetFrame.Claim
local UnitGUID = UnitGUID
local UnitHealth = UnitHealth


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    unit = #UNIT#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    instance.gameEvents = { "PLAYER_TARGET_CHANGED" }

    instance.ValueHandler = { validKeys = { [6] = true, } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
                inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] instance.unit, },
                value = 2,
            },
            {
                eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                inputValues = { --[[unit]] instance.unit },
                comparisonValues =
                {
                    value = 0,
                    type = "GreaterThan"
                },
                value = 4,
            },
        },
    }

    instance.listenerGroups = {}

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.OnEvent = this.OnEvent
    instance.OnRaidMarkerNotify = this.OnRaidMarkerNotify
    instance.OnHealthNotify = this.OnHealthNotify
    instance.OnTargetClassificationNotify = this.OnTargetClassificationNotify
    instance.OnTargetLevelNotify = this.OnTargetLevelNotify
    instance.OnPlayerLevelNotify = this.OnPlayerLevelNotify
    instance.OnTargetReactionNotify = this.OnTargetReactionNotify
    instance.OnIsTargetPlayerNotify = this.OnIsTargetPlayerNotify
    instance.OnTargetFactionNotify = this.OnTargetFactionNotify
    instance.OnNameNotify = this.OnNameNotify
    instance.OnAuraNotify = this.OnAuraNotify
    instance.OnIsBossNotify = this.OnIsBossNotify
    instance.OnHealthChangePerSecondNotify = this.OnHealthChangePerSecondNotify

    inherited.Setup(
        instance,
        "targetFrame",
        "creator"
    )

    instance.auraSpellIDs = DoTSpellIDsGet()
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
                inputValues = { --[[unitGUID]] UnitGUID(self.unit), --[[lookbackDuration]] healthChangePerSecondLookbackDuration },
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

local function ListenerGroupsSetup(self)
    -- Raid Marker
    self.RaidMarkerListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_RAID_MARKER_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.RaidMarkerListenerGroup,
        self,
        "OnRaidMarkerNotify"
    )
    self.RaidMarkerListenerGroup:Activate()

    -- Health
    self.HealthListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.HealthListenerGroup,
        self,
        "OnHealthNotify"
    )
    self.HealthListenerGroup:Activate()

    -- Challenge
    self.TargetClassificationListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_CLASSIFICATION_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.TargetClassificationListenerGroup,
        self,
        "OnTargetClassificationNotify"
    )
    self.TargetClassificationListenerGroup:Activate()

    self.TargetLevelListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_LEVEL_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.TargetLevelListenerGroup,
        self,
        "OnTargetLevelNotify"
    )
    self.TargetLevelListenerGroup:Activate()

    self.PlayerLevelListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_LEVEL_CHANGED",
                inputValues = { --[[unit]] "player", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.PlayerLevelListenerGroup,
        self,
        "OnPlayerLevelNotify"
    )
    self.PlayerLevelListenerGroup:Activate()

    self.TargetReactionListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_REACTION_CHANGED",
                inputValues = { --[[unit1]] "target", --[[unit2]] "player", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.TargetReactionListenerGroup,
        self,
        "OnTargetReactionNotify"
    )
    self.TargetReactionListenerGroup:Activate()

    self.IsTargetPlayerListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_IS_PLAYER_CHANGED",
                inputValues = { --[[unit]] "target", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.IsTargetPlayerListenerGroup,
        self,
        "OnIsTargetPlayerNotify"
    )
    self.isTargetPlayer = false
    self.IsTargetPlayerListenerGroup:Activate()

    self.TargetFactionListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_FACTION_CHANGED",
                inputValues = { --[[unit]] "target", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.TargetFactionListenerGroup,
        self,
        "OnTargetFactionNotify"
    )
    self.TargetFactionListenerGroup:Activate()

    -- Name
    self.NameListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_NAME_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.NameListenerGroup,
        self,
        "OnNameNotify"
    )
    self.NameListenerGroup:Activate()

    -- Auras
    for i = 1, #self.auraSpellIDs do
        local spellID = self.auraSpellIDs[i]
        local key = table.concat({ "AuraListenerGroup_", spellID })

        self[key] =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] self.unit, --[[spellID]] spellID, },
                },
            },
        }

        NotifyBasedFunctionCallerSetup(
            self[key],
            self,
            "OnAuraNotify"
        )
        self[key]:Activate()
    end

    -- Is Boss
    self.IsBossListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_IS_BOSS_CHANGED",
                inputValues = { --[[unit]] self.unit, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.IsBossListenerGroup,
        self,
        "OnIsBossNotify"
    )
    self.IsBossListenerGroup:Activate()
end

local function ListenerGroupsTeardown(self)
    self.RaidMarkerListenerGroup:Deactivate()
    self.HealthListenerGroup:Deactivate()
    self.TargetClassificationListenerGroup:Deactivate()
    self.TargetLevelListenerGroup:Deactivate()
    self.PlayerLevelListenerGroup:Deactivate()
    self.TargetReactionListenerGroup:Deactivate()
    self.IsTargetPlayerListenerGroup:Deactivate()
    self.TargetFactionListenerGroup:Deactivate()
    self.NameListenerGroup:Deactivate()
    self.IsBossListenerGroup:Deactivate()
    if self.HealthChangePerSecondListenerGroup ~= nil then
        self.HealthChangePerSecondListenerGroup:Deactivate()
    end

    self.isBoss = false

    -- Auras
    for i = 1, #self.auraSpellIDs do
        local spellID = self.auraSpellIDs[i]
        local key = table.concat({ "AuraListenerGroup_", spellID })

        self[key]:Deactivate()
        self[key] = nil
    end
end

function this:Modify(frame)
    frame.targetFrame = TargetFrameClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, "PRIMARY", self.auraSpellIDs)
    self.targetFrame = frame.targetFrame
    ListenerGroupsSetup(self)
    EventsRegister(self)
end

function this:Demodify(frame)
    frame.targetFrame:Release()
    self.targetFrame = nil
    self.targetClassification = nil
    self.targetLevel = nil
    self.playerLevel = nil
    self.targetReaction = nil
    self.isTargetPlayer = nil
    self.targetFaction = nil
    ListenerGroupsTeardown(self)
    EventsDeregister(self)
end

function this:OnEvent(event) -- PLAYER_TARGET_CHANGED
    if self.isBoss == true then
        self.HealthChangePerSecondListenerGroup:Deactivate()
        HealthChangePerSecondListenerGroupSetup(self)
    end
end

function this:OnRaidMarkerNotify(event, value)
    self.targetFrame:RaidMarkerSet(value)
end

function this:OnHealthNotify(event, value)
    self.targetFrame:HealthSet(value)
end

local function ChallengeSet(self)
    if self.targetClassification ~= nil
        and self.targetLevel ~= nil
        and self.playerLevel ~= nil
        and self.targetReaction ~= nil
        and self.isTargetPlayer ~= nil
        and self.targetFaction ~= nil
        then
        self.targetFrame:ChallengeSet(self.targetClassification, self.targetLevel, self.playerLevel, self.targetReaction, self.isTargetPlayer, self.targetFaction)
    end
end

function this:OnTargetClassificationNotify(event, value)
    self.targetClassification = value
    ChallengeSet(self)
end

function this:OnTargetLevelNotify(event, value)
    self.targetLevel = value
    ChallengeSet(self)
end

function this:OnPlayerLevelNotify(event, value)
    self.playerLevel = value
    ChallengeSet(self)
end

function this:OnTargetReactionNotify(event, value)
    self.targetReaction = value
    ChallengeSet(self)
end

function this:OnIsTargetPlayerNotify(event, value)
    self.isTargetPlayer = value
    ChallengeSet(self)
end

function this:OnTargetFactionNotify(event, value)
    self.targetFaction = value
    ChallengeSet(self)
end

function this:OnNameNotify(event, value)
    self.targetFrame:NameSet(value)
end

function this:OnAuraNotify(event, value, inputGroup)
    self.targetFrame:AuraSet(inputGroup.inputValues[3], value)
end

function this:OnIsBossNotify(event, value)
    if self.isBoss ~= value then
        self.isBoss = value

        if self.isBoss == true then
            HealthChangePerSecondListenerGroupSetup(self)
        elseif self.HealthChangePerSecondListenerGroup ~= nil then
            self.HealthChangePerSecondListenerGroup:Deactivate()
        end
    end

    self.targetFrame:IsBossSet(value)
end

function this:OnHealthChangePerSecondNotify(event, value)
    self.targetFrame:TimeUntilDeathSet(UnitHealth(self.unit), value)
end