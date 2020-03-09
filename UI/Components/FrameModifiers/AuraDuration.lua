TheEye.Core.UI.Components.AuraDuration = {}
local this = TheEye.Core.UI.Components.AuraDuration
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local EventDeregister = TheEye.Core.Managers.Events.Deregister
local EventRegister = TheEye.Core.Managers.Events.Register
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FontTemplate = TheEye.Core.Data.FontTemplates.Icon.Active
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local UnitAuraGetBySpellID = TheEye.Core.Helpers.Auras.UnitAuraGetBySpellID


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

    if auraData ~= nil then
        local remainingTime = auraData[6] - GetTime()

        if remainingTime < 0 then
            remainingTime = 0
        end

        self.instance:SetText(math.floor(remainingTime + 0.5))
    end
end