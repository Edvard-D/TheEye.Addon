TheEyeAddon.UI.Components.AuraDuration = {}
local this = TheEyeAddon.UI.Components.AuraDuration
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local EventDeregister = TheEyeAddon.Managers.Events.Deregister
local EventRegister = TheEyeAddon.Managers.Events.Register
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FontTemplate = TheEyeAddon.Values.FontTemplates.Icon.Active
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local UnitAuraGetBySpellID = TheEyeAddon.Helpers.Auras.UnitAuraGetBySpellID


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
]]
function this.Setup(
    instance
)

    instance.ValueHandler = { validKeys = { [2] = true, } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] instance.spellID, },
                comparisonValues =
                {
                    value = 0,
                    type = "GreaterThan",
                },
                value = 2,
            },
        },
    }

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
	instance.customEvents = { "UPDATE", }
    instance.OnEvent = this.OnEvent

    inherited.Setup(
        instance,
        "text",
        "creator"
    )
end

function this:Modify(frame)
    frame.text = frame.text or FontStringCreate(frame)
    self.instance = frame.text
    self.instance:StyleSet("OVERLAY", FontTemplate, "CENTER")
    EventRegister(self)
end

function this:Demodify(frame)
    frame.text:SetText(nil)
    self.instance = nil
    EventDeregister(self)
end

function this:OnEvent(event, value)
    local auraData = UnitAuraGetBySpellID("_", "player", self.spellID)
    local remainingTime = auraData[6] - GetTime()

    if remainingTime < 0 then
        remainingTime = 0
    end

    self.instance:SetText(math.floor(remainingTime + 0.5))
end