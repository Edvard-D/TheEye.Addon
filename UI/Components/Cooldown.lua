TheEyeAddon.UI.Components.Cooldown = {}
local this = TheEyeAddon.UI.Components.Cooldown
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local CooldownClaim = TheEyeAddon.UI.Factories.Cooldown.Claim
local EnabledStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup
local GetSpellCooldown = GetSpellCooldown
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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

    inherited.Setup(
        instance,
        uiObject,
        this.OnValidKey,
        this.OnInvalidKey
    )
    
    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        uiObject,
        instance,
        1
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end

function this:OnValidKey(state)
    SendCustomEvent("UIOBJECT_COOLDOWN_SHOWN", self.UIObject)
    self.frame = CooldownClaim(uiObject, self.UIObject.frame, nil)
    self.frame:SetAllPoints()
    self.frame:SetDrawBling(false)
    self.frame:SetDrawEdge(false)
    local startTime, duration = GetSpellCooldown(self.spellID)
    self.frame:SetCooldown(startTime, duration)
end

function this:OnInvalidKey(state)
    SendCustomEvent("UIOBJECT_COOLDOWN_HIDDEN", self.UIObject)
    self.frame:Release()
    self.frame = nil
end