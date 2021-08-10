TheEye.Core.UI.Components.InteractionsGroup = {}
local this = TheEye.Core.UI.Components.InteractionsGroup
local inherited = TheEye.Core.UI.Components.Group

local displayMaxElapsedActiveInCombatTime = 10
local displayMaxElapsedInteractionTime = 30
local DoTSpellIDsGet = TheEye.Core.Managers.Icons.DoTSpellIDsGet
local EventsDeregister = TheEye.Core.Managers.Events.Deregister
local EventsRegister = TheEye.Core.Managers.Events.Register
local FormatData = TheEye.Core.Managers.UI.FormatData
local GetRaidTargetIndex = GetRaidTargetIndex
local GetTime = GetTime
local IsEncounterInProgress = IsEncounterInProgress
local IsUnitBoss = TheEye.Core.Helpers.Unit.IsUnitBoss
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local UIObjectSetup = TheEye.Core.Managers.UI.UIObjectSetup
local UnitAuraGetBySpellID = TheEye.Core.Helpers.Auras.UnitAuraGetBySpellID
local UnitClassification = UnitClassification
local UnitIsDead = UnitIsDead
local UnitFactionGroup = UnitFactionGroup
local UnitGUID = UnitGUID
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsEnemy = UnitIsEnemy
local UnitIsPlayer = UnitIsPlayer
local UnitLevel = UnitLevel
local UnitName = UnitName
local UnitReaction = UnitReaction


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    inherited.Setup(
        instance
    )

    instance.OnDeactivate = this.OnDeactivate
    instance.OnPlayerLevelNotify = this.OnPlayerLevelNotify
    instance.OnCombatLogNotify = this.OnCombatLogNotify
    instance.OnEvent = this.OnEvent

    instance.playerGUID = UnitGUID("player")
    instance.auraSpellIDs = DoTSpellIDsGet()

    instance.gameEvents = { "PLAYER_TARGET_CHANGED", "UNIT_THREAT_SITUATION_UPDATE" }
    instance.customEvents = { "UPDATE" }
    EventsRegister(instance)

    -- PlayerLevelListenerGroup
    instance.PlayerLevelListenerGroup =
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
        instance.PlayerLevelListenerGroup,
        instance,
        "OnPlayerLevelNotify"
    )
    instance.PlayerLevelListenerGroup:Activate()

    -- CombatLogListenerGroup
    instance.CombatLogListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_CAST_START", --[[sourceUnit]] "player", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "RANGE_DAMAGE", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SWING_DAMAGE", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_DAMAGE", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_PERIODIC_DAMAGE", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_HEAL", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_PERIODIC_HEAL", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_AURA_APPLIED", --[[sourceUnit]] "player", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_AURA_BROKEN", --[[sourceUnit]] "player", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "SPELL_AURA_REMOVED", --[[sourceUnit]] "player", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "UNIT_DESTROYED", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "UNIT_DIED", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
            {
                eventEvaluatorKey = "COMBAT_LOG",
                inputValues = { --[[eventName]] "UNIT_DISSIPATES", --[[sourceUnit]] "_", --[[destUnit]] "_" }
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        instance.CombatLogListenerGroup,
        instance,
        "OnCombatLogNotify"
    )
    instance.CombatLogListenerGroup:Activate()
end

function this:OnDeactivate()
    EventsDeregister(self)
    self.PlayerLevelListenerGroup:Deactivate()
    self.CombatLogListenerGroup:Deactivate()

    for i = #self.childUIObjects, 1, -1 do
        childUIObject:Deactivate()
        TheEye.Core.UI.Objects.Instances[childUIObject.key] = nil
    end

    for i = 1, #self.trackedGUIDs do
        self.trackedGUIDs[i].UIObject = nil
        self.trackedGUIDs[i] = nil
    end
end

local function TargetFrameUpdate(data)
    if data.UIObject == nil then
        return 
    end
    
    local targetFrameInteraction = data.UIObject.TargetFrameInteraction
    targetFrameInteraction:RaidMarkerSet(data.raidTargetIndex)
    targetFrameInteraction:HealthSet(data.health, data.healthMax)
    for spellID, isVisible in pairs(data.auras) do
        targetFrameInteraction:AuraSet(spellID, isVisible)
    end
end

local function TargetFrameCreate(self, guid, data)
    local uiObject =
    {
        tags = { "TARGET_FRAME_INTERACTION", guid },
        Child =
        {
            parentKey = self.UIObject.key,
        },
        ElapsedTimeTracker = {},
        EnabledState =
        {
            ValueHandler =
            {
                validKeys = { [2] = true, },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                        inputValues = { --[[uiObjectKey]] self.UIObject.key, --[[componentName]] "VisibleState" },
                        value = 2,
                    },
                },
            },
        },
        Frame =
        {
            Dimensions = TheEye.Core.Data.DimensionTemplates.TargetFrameInteraction,
        },
        TargetFrameInteraction =
        {
            unitGUID = guid,
            auraSpellIDs = self.auraSpellIDs,
        },
        VisibleState =
        {
            ValueHandler =
            {
                validKeys = { [0] = true },
            },
        },
    }

    FormatData(uiObject)
    UIObjectSetup(uiObject)
    data.UIObject = uiObject

    uiObject.ElapsedTimeTracker:Change(data.targetedTimestamp)
    TargetFrameUpdate(data)
    local targetFrameInteraction = data.UIObject.TargetFrameInteraction
    targetFrameInteraction:ChallengeSet(data.classification, data.level, self.playerLevel, data.reaction, data.isPlayer, data.faction)
    targetFrameInteraction:NameSet(data.name)
    targetFrameInteraction:IsBossSet(data.isBoss)
end

local function DisplayedTargetFramesUpdate(self)
    for guid, data in pairs(self.trackedGUIDs) do
        if data.lastInteractionTimestamp ~= nil and data.UIObject == nil and guid ~= self.currentTargetGUID then
            TargetFrameCreate(self, guid, data)
        elseif data.UIObject ~= nil and guid == self.currentTargetGUID then
            data.UIObject:Deactivate()
            TheEye.Core.UI.Objects.Instances[data.UIObject.key] = nil
            data.UIObject = nil
        end
    end
end

local function TrackedGUIDRemove(self, guid, wasKilled)
    local uiObject = self.trackedGUIDs[guid].UIObject

    if uiObject ~= nil then
        uiObject:Deactivate()
        TheEye.Core.UI.Objects.Instances[uiObject.key] = nil
        self.trackedGUIDs[guid].UIObject = nil
    end
    self.trackedGUIDs[guid] = nil
end

function this:OnPlayerLevelNotify(event, value)
    self.playerLevel = value

    if self.trackedGUIDs == nil then
        return
    end

    for i = 1, #self.trackedGUIDs do
        local data = self.trackedGUIDs[i]

        if data.UIObject ~= nil then
            data.UIObject.TargetFrameInteraction:ChallengeSet(data.classification, data.level, self.playerLevel, data.reaction, data.isPlayer, data.faction)
        end
    end
end

function this:OnCombatLogNotify(event, _, inputGroup)
    local eventData = inputGroup.eventData
    
    if event ~= "SPELL_CAST_START" and table.haskey(self.trackedGUIDs, eventData.destGUID) == false then
        return
    end

    if event == "SPELL_CAST_START" then
        if self.trackedGUIDs == nil then
            return
        end

        local data = self.trackedGUIDs[self.currentTargetGUID]

        if data ~= nil then
            data.lastInteractionTimestamp = GetTime()
            DisplayedTargetFramesUpdate(self)
        end
    elseif (event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE") then
        self.trackedGUIDs[eventData.destGUID].health = self.trackedGUIDs[eventData.destGUID].health - eventData.amount
        self.lastActiveInCombatTimestamp = GetTime()

        if eventData.overkill <= 0 then
            TargetFrameUpdate(self.trackedGUIDs[eventData.destGUID])
        else
            TrackedGUIDRemove(self, eventData.destGUID, true)
        end
    elseif event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL" then
        self.trackedGUIDs[eventData.destGUID].health = self.trackedGUIDs[eventData.destGUID].health + eventData.amount
        self.lastActiveInCombatTimestamp = GetTime()
        TargetFrameUpdate(self.trackedGUIDs[eventData.destGUID])
    elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_BROKEN" or event == "SPELL_AURA_REMOVED" then
        local auras = self.trackedGUIDs[eventData.destGUID].auras

        if table.haskey(auras, eventData.spellID) == true then
            if event == "SPELL_AURA_APPLIED" then
                auras[eventData.spellID] = true
            else -- SPELL_AURA_BROKEN or SPELL_AURA_REMOVED
                auras[eventData.spellID] = false
            end

            TargetFrameUpdate(self.trackedGUIDs[eventData.destGUID])
        end
    elseif event == "UNIT_DESTROYED" or event == "UNIT_DIED" or event == "UNIT_DISSIPATES" then
        TrackedGUIDRemove(self, eventData.destGUID, true)
    end
end

function this:OnEvent(event)
    if event == "PLAYER_TARGET_CHANGED" then
        if UnitIsDead("target") == true then
            return
        end

        self.currentTargetGUID = UnitGUID("target")

        if self.trackedGUIDs == nil then
            self.trackedGUIDs = {}
        end

        local currentTargetRaidTargetIndex = GetRaidTargetIndex("target")
        if currentTargetRaidTargetIndex ~= nil then
            for guid, data in pairs(self.trackedGUIDs) do
                if guid ~= self.currentTargetGUID and data.raidTargetIndex == currentTargetRaidTargetIndex then
                    data.raidTargetIndex = nil
                    TargetFrameUpdate(data)
                end
            end
        end

        if self.trackedGUIDs[self.currentTargetGUID] == nil
            and self.currentTargetGUID ~= self.playerGUID
            and self.currentTargetGUID ~= nil
            then
            local auras = {}
            for i = 1, #self.auraSpellIDs do
                local spellID = self.auraSpellIDs[i]

                if UnitAuraGetBySpellID("player", "target", spellID) ~= nil then
                    auras[spellID] = true
                else
                    auras[spellID] = false
                end
            end

            self.trackedGUIDs[self.currentTargetGUID] =
            {
                auras = auras,
                classification = UnitClassification("target"),
                faction = UnitFactionGroup("target") or "None",
                health = UnitHealth("target"),
                healthMax = UnitHealthMax("target"),
                isBoss = IsUnitBoss("target"),
                isPlayer = UnitIsPlayer("target"),
                level = UnitLevel("target"),
                name = UnitName("target"),
                raidTargetIndex = currentTargetRaidTargetIndex,
                reaction = UnitReaction("target", "player"),
                targetedTimestamp = GetTime(),
            }
        end

        DisplayedTargetFramesUpdate(self)
    elseif event == "UNIT_THREAT_SITUATION_UPDATE" then
        if self.trackedGUIDs == nil
            or self.currentTargetGUID == nil
            or self.trackedGUIDs[self.currentTargetGUID] == nil
            then
            return
        end

        local reaction = UnitReaction("target", "player")

        if reaction ~= nil
            and reaction >= 4
            and self.trackedGUIDs[self.currentTargetGUID].reaction < 4
            then
            TrackedGUIDRemove(self, self.currentTargetGUID, false)
        else
            self.trackedGUIDs[self.currentTargetGUID].reaction = reaction
        end
    else -- UPDATE
        if self.trackedGUIDs == nil then
            return
        end

        local currentTime = GetTime()

        for guid, data in pairs(self.trackedGUIDs) do
            if data ~= nil
                and guid ~= self.currentTargetGUID
                and (data.lastInteractionTimestamp == nil
                    or currentTime - data.lastInteractionTimestamp > displayMaxElapsedInteractionTime)
                and currentTime - data.targetedTimestamp > displayMaxElapsedInteractionTime
                and (IsEncounterInProgress() == false
                    or data.lastActiveInCombatTimestamp == nil
                    or currentTime - data.lastActiveInCombatTimestamp > displayMaxElapsedActiveInCombatTime)
                then
                TrackedGUIDRemove(self, guid, false)
            end
        end

        local count = table.count(self.trackedGUIDs)
        if self.previousCount == nil or self.previousCount ~= count then
            print("count: " .. count)
            self.previousCount = count
        end
    end
end