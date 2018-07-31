TheEyeAddon.UI.Components.ReadySoonAlert = {}
local this = TheEyeAddon.UI.Components.ReadySoonAlert
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local auraFilters = TheEyeAddon.Values.auraFilters
local CooldownClaim = TheEyeAddon.UI.Factories.Cooldown.Claim
local EnabledStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup
local GetSpellCooldown = GetSpellCooldown
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
                comparisonValues =
                {
                    floor = 0,
                    ceiling = TheEyeAddon.Values.ReadySoonAlertLengthGet,
                    type = "Between",
                },
                value = 2,
            },
        },
    }
    if auraFilters[instance.spellID] == nil then
        instance.ListenerGroup.Listeners[1].eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED"
        instance.ListenerGroup.Listeners[1].inputValues = { --[[spellID]] instance.spellID }
    else
        instance.ListenerGroup.Listeners[1].eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED"
        instance.ListenerGroup.Listeners[1].inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] instance.spellID }
    end

    inherited.Setup(
        instance,
        uiObject,
        this.OnValidKey,
        this.OnInvalidKey -- @TODO
    )
    
    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        uiObject,
        instance
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end

function this:OnValidKey(state)
    local startTime = 0
    local duration = 0

    SendCustomEvent("UIOBJECT_FRAME_USER_REGISTERED", self.UIObject)
    self.frame = CooldownClaim(uiObject, self.UIObject.frame, nil)
    self.frame:SetAllPoints()
    self.frame:SetDrawBling(false)
    self.frame:SetDrawEdge(false)

    -- @REFACTOR This data should probably be passed by Event Evaluators
    if auraFilters[instance.spellID] == nil then
        startTime, duration = GetSpellCooldown(self.spellID)
    else
        -- @TODO
    end
    
    self.frame:SetCooldown(startTime, duration)
end