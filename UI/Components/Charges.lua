TheEyeAddon.UI.Components.Charges = {}
local this = TheEyeAddon.UI.Components.Charges
local inherited = TheEyeAddon.UI.Components.FrameModifier

local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FontTemplate = TheEyeAddon.Values.FontTemplates.Icon.Default
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup


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
                eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                inputValues = { --[[spellID]] instance.spellID, },
                comparisonValues =
                {
                    value = 1,
                    type = "GreaterThanEqualTo",
                },
                value = 2,
            },
        },
    }

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        "text",
        "creator"
    )

    -- TextValueListenerGroup
    instance.OnNotify = this.OnNotify

    instance.TextValueListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                inputValues = { --[[spellID]] instance.spellID, },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        instance.TextValueListenerGroup,
        instance,
        "OnNotify"
    )
end

function this:Modify(frame)
    frame.text = frame.text or FontStringCreate(frame)
    self.instance = frame.text
    self.instance:StyleSet("OVERLAY", FontTemplate, "CENTER")
    self.TextValueListenerGroup:Activate()
end

function this:Demodify(frame)
    self.TextValueListenerGroup:Deactivate()
    frame.text:SetText(nil)
    self.instance = nil
end

function this:OnNotify(event, value)
    self.instance:SetText(value)
end