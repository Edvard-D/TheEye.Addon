TheEyeAddon.UI.Components.EncounterAlert = {}
local this = TheEyeAddon.UI.Components.EncounterAlert
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local fontColor = { 255, 0.75, 0.16, 1, }
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FontTemplate = TheEyeAddon.Data.FontTemplates.EncounterAlert
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local unpack = unpack


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    instance.ValueHandler = { validKeys = { [0] = true, } }

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
                eventEvaluatorKey = "DBM_ANNOUNCEMENT_ELAPSED_TIME_CHANGED",
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
    frame.text:SetTextColor(unpack(fontColor))
    self.instance = frame.text
    self.instance:StyleSet("OVERLAY", FontTemplate, "CENTER")
    self.TextValueListenerGroup:Activate()
end

function this:Demodify(frame)
    self.TextValueListenerGroup:Deactivate()
    frame.text:SetText(nil)
    self.instance = nil
end

function this:OnNotify(event, value, inputGroup)
    self.instance:SetText(inputGroup.eventData.message)
end