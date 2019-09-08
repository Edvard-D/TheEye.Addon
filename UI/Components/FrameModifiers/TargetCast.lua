TheEyeAddon.UI.Components.TargetCast = {}
local this = TheEyeAddon.UI.Components.TargetCast
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local CastBarClaim = TheEyeAddon.UI.Factories.CastBar.Claim
local colors =
{
    background = { 0.1, 0.1, 0.1, 1 },
    immune = { 0.5, 0.5, 0.5, 1 },
    interruptable = { 0.8, 0.46, 0.19, 1 },
}
local fontTemplate = TheEyeAddon.Values.FontTemplates.TargetCast.CastName
local GetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table


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
        "castBar",
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
    frame.castbar = CastBarClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, self.unit, colors, true, true, true, fontTemplate)
    self.castbar = frame.castbar
    ListenerGroupsSetup(self)
end

function this:Demodify(frame)
    frame.castbar:Release()
    self.castbar = nil
    ListenerGroupsTeardown(self)
end

function this:OnCastNotify(event, value)
    if value == true then
        self.castbar:CastSet()
    end
end

function this:OnInterruptNotify(event, value, inputGroup)
    self.castbar:SecondaryIconSet(value, inputGroup.inputValues[1])
end