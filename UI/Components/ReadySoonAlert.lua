-- @REFACTOR Rename to CastSoonAlert
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
    ValueHandler = nil
    ListenerGroup = nil
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
    
    instance.name = this.name
    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        uiObject
    )
end

function this:Modify(frame)
    if self.frame == nil then
        self.frame = CooldownClaim(self.UIObject, frame, nil)
        self.frame:SetAllPoints()
        self.frame:SetDrawBling(false)
        self.frame:SetDrawEdge(false)
        self.frame:SetCooldown(GetTime(), ReadySoonAlertLengthGet())
    end
end

function this:Demodify()
    if self.frame ~= nil then
        self.frame:Release()
        self.frame = nil
    end
end