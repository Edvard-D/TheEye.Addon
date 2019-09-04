TheEyeAddon.UI.Components.TargetAction = {}
local this = TheEyeAddon.UI.Components.TargetAction
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local GetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table
local TargetActionClaim = TheEyeAddon.UI.Factories.TargetAction.Claim


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
    instance.OnCastNotify = this.OnCastNotify
    instance.OnInterruptNotify = this.OnInterruptNotify


    inherited.Setup(
        instance,
        "targetAction",
        "creator"
    )
    
    instance.interruptSpellIDs = this.InterruptSpellIDsGet()
end

function this.InterruptSpellIDsGet()
    local interruptSpellIDs = {}

    local icons = GetFiltered(
        {
            {
                {
                    type = "CATEGORY",
                    value = "CC",
                    subvalue = "INTERRUPT",
                },
            },
        }
    )

    for i = 1, #icons do
        local OBJECT_ID = GetPropertiesOfType(icons[i], "OBJECT_ID")
        table.insert(interruptSpellIDs, OBJECT_ID.value)
    end

    table.sort(interruptSpellIDs, function(a,b)
        return a < b
    end)

    return interruptSpellIDs
end

local function ListenerGroupsSetup(self)
    -- Cast
    self.CastListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                inputValues = { --[[unit]] self.unit, --[[spellID]] "_", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.CastListenerGroup,
        self,
        "OnCastNotify"
    )
    self.CastListenerGroup:Activate()

    -- Interrupts
    for i = 1, #self.interruptSpellIDs do
        local spellID = self.interruptSpellIDs[i]
        local key = table.concat({ "InterruptListenerGroup_", spellID })

        self[key] =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo"
                    },
                },
            },
        }
        NotifyBasedFunctionCallerSetup(
            self[key],
            self,
            "OnInterruptNotify"
        )
        self[key]:Activate()
    end
end

local function ListenerGroupsTeardown(self)
    self.CastListenerGroup:Deactivate()

    -- Interrupts
    for i = 1, #self.interruptSpellIDs do
        local spellID = self.interruptSpellIDs[i]
        local key = table.concat({ "InterruptListenerGroup_", spellID })

        self[key]:Deactivate()
        self[key] = nil
    end
end

function this:Modify(frame)
    frame.targetAction = TargetActionClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, self.unit, self.dotSpellIDs)
    self.targetAction = frame.targetAction
    ListenerGroupsSetup(self)
end

function this:Demodify(frame)
    frame.targetAction:Release()
    self.targetAction = nil
    ListenerGroupsTeardown(self)
end

function this:OnCastNotify(event, value)
    if value == true then
        self.targetAction:CastSet()
    end
end

function this:OnInterruptNotify(event, value, inputGroup)
    self.targetAction:InterruptSet(value, inputGroup.inputValues[1])
end