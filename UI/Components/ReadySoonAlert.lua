TheEyeAddon.UI.Components.ReadySoonAlert = {}
local this = TheEyeAddon.UI.Components.ReadySoonAlert
this.name = "ReadySoonAlert"
local inherited = TheEyeAddon.UI.Components.FrameModifier

local auraFilters = TheEyeAddon.Values.auraFilters
local CooldownClaim = TheEyeAddon.UI.Factories.Cooldown.Claim
local GetTime = GetTime
local ReadySoonAlertLengthGet = TheEyeAddon.Values.ReadySoonAlertLengthGet


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

    -- StateHandler
    instance.StateHandler = {}
    instance.StateHandler.ValueHandler = { validKeys = { [2] = true } }
    instance.StateHandler.ListenerGroup =
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
        instance.StateHandler.ListenerGroup.Listeners[1].eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED"
        instance.StateHandler.ListenerGroup.Listeners[1].inputValues = { --[[spellID]] instance.spellID }
    else
        instance.StateHandler.ListenerGroup.Listeners[1].eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED"
        instance.StateHandler.ListenerGroup.Listeners[1].inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] instance.spellID }
    end
    
    instance.name = this.name
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        uiObject
    )
end

function this:Modify(frame)
    self.frame = CooldownClaim(self.UIObject, frame, nil)
    self.frame:SetAllPoints()
    self.frame:SetDrawBling(false)
    self.frame:SetDrawEdge(false)
    self.frame:SetCooldown(GetTime(), ReadySoonAlertLengthGet())
end

function this:Demodify()
    self.frame:Release()
    self.frame = nil
end