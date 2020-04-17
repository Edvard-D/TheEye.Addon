TheEye.Core.UI.Components.LowPowerAlert = {}
local this = TheEye.Core.UI.Components.LowPowerAlert
local inherited = TheEye.Core.UI.Components.FrameModifierBase

this.lowPowerThreshold = 0.5

local EventDeregister = TheEye.Core.Managers.Events.Deregister
local EventRegister = TheEye.Core.Managers.Events.Register
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FontTemplate = TheEye.Core.Data.FontTemplates.Icon.Active
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = nil
    ListenerGroup = nil
    powerID = #POWER#ID#
    spellID = #SPELL#ID#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    instance.ValueHandler = { validKeys = { [6] = true, } }
    instance.ListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] instance.spellID, },
                value = 2,
            },
            {
                eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                inputValues = { --[[unit]] "player", --[[powerID]] instance.powerID, },
                comparisonValues =
                {
                    value = TheEye.Core.Data.powerLowThreshold,
                    type = "LessThanEqualTo",
                },
                value = 4,
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
    local percent = UnitPower("player", self.powerID) / UnitPowerMax("player", self.powerID)

    self.instance:SetText(math.floor((percent * 100) + 0.5))
end