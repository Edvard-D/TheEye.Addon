TheEyeAddon.UI.Components.TargetFrame = {}
local this = TheEyeAddon.UI.Components.TargetFrame
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local GetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table
local TargetFrameClaim = TheEyeAddon.UI.Factories.TargetFrame.Claim


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

    instance.ValueHandler = { validKeys = { [0] = true, } }
    instance.listenerGroups = {}

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.OnPlayerCastNotify = this.OnPlayerCastNotify
    instance.OnRaidMarkerNotify = this.OnRaidMarkerNotify
    instance.OnHealthNotify = this.OnHealthNotify
    instance.OnNameNotify = this.OnNameNotify
    instance.OnDoTNotify = this.OnDoTNotify

    inherited.Setup(
        instance,
        "targetFrame",
        "creator"
    )

    instance.dotSpellIDs = this.DoTSpellIDsGet()
end

function this.DoTSpellIDsGet()
    local dotSpellIDs = {}

    local icons = GetFiltered(
        {
            {
                {
                    type = "CATEGORY",
                    value = "DAMAGE",
                    subvalue = "PERIODIC",
                },
            },
        }
    )

    for i = 1, #icons do
        local OBJECT_ID = GetPropertiesOfType(icons[i], "OBJECT_ID")
        table.insert(dotSpellIDs, OBJECT_ID.value)
    end

    table.sort(dotSpellIDs, function(a,b)
        return a < b
    end)

    return dotSpellIDs
end

local function ListenerGroupsSetup(self)
    -- Player Cast
    --self.PlayerCastListenerGroup =
    --{
    --    Listeners =
    --    {
    --        {
    --            eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
    --            inputValues = { --[[unit]] "player", --[[spellID]] "_", },
    --        },
    --    },
    --}
    --NotifyBasedFunctionCallerSetup(
    --    self.PlayerCastListenerGroup,
    --    self,
    --    "OnPlayerCastNotify"
    --)
    --self.PlayerCastListenerGroup:Activate()

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

    -- DoTs
    for i = 1, #self.dotSpellIDs do
        local spellID = self.dotSpellIDs[i]
        local key = table.concat({ "DoTListenerGroup_", spellID })

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
            "OnDoTNotify"
        )
        self[key]:Activate()
    end
end

local function ListenerGroupsTeardown(self)
    --self.PlayerCastListenerGroup:Deactivate()
    self.RaidMarkerListenerGroup:Deactivate()
    self.HealthListenerGroup:Deactivate()
    self.NameListenerGroup:Deactivate()

    -- DoTs
    for i = 1, #self.dotSpellIDs do
        local spellID = self.dotSpellIDs[i]
        local key = table.concat({ "DoTListenerGroup_", spellID })

        self[key]:Deactivate()
        self[key] = nil
    end
end

function this:Modify(frame)
    frame.targetFrame = TargetFrameClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, self.unit, self.dotSpellIDs)
    self.targetFrame = frame.targetFrame
    ListenerGroupsSetup(self)
end

function this:Demodify(frame)
    frame.targetFrame:Release()
    self.targetFrame = nil
    ListenerGroupsTeardown(self)
end

--[[function this:OnPlayerCastNotify(event, value)
    if value == true then
        local isChannel = false
        local startTime, endTime = select(4, UnitCastingInfo("player"))
        if startTime == nil then
            isChannel = true
            startTime, endTime = select(4, UnitChannelInfo("player"))
        end
        local duration = (endTime - startTime) / 1000

        self.targetFrame:PlayerCastSet(true, (startTime) / 1000, duration, isChannel)
    else
        self.targetFrame:PlayerCastSet(false)
    end
end]]

function this:OnRaidMarkerNotify(event, value)
    self.targetFrame:RaidMarkerSet(value)
end

function this:OnHealthNotify(event, value)
    self.targetFrame:HealthSet(value)
end

function this:OnNameNotify(event, value)
    self.targetFrame:NameSet(value)
end

function this:OnDoTNotify(event, value, inputGroup)
    self.targetFrame:DoTSet(inputGroup.inputValues[3], value)
end