TheEyeAddon.UI.Components.ContextIcon = {}
local this = TheEyeAddon.UI.Components.ContextIcon
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local DimensionTemplate = TheEyeAddon.Data.DimensionTemplates.Icon.Context
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FontTemplate = TheEyeAddon.Data.FontTemplates.Icon.Context
local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create
local TextureFileIDGet = TheEyeAddon.Helpers.Files.TextureFileIDGet


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    iconObjectType = #ICON#TYPE#
    iconObjectID = #ICON#ID#
    #OPTIONAL#TextValueListenerGroup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        "context",
        "creator"
    )

    -- TextValueListenerGroup
    if instance.TextValueListenerGroup ~= nil then
        instance.OnNotify = this.OnNotify

        NotifyBasedFunctionCallerSetup(
            instance.TextValueListenerGroup,
            instance,
            "OnNotify"
        )
    end
end

function this:Modify(frame)
    frame.context = FrameClaim(self.UIObject, "Frame", frame, nil, DimensionTemplate)
    self.instance = frame.context

    self.instance.background = self.instance.background or TextureCreate(self.instance, "BACKGROUND")
    self.iconTextureFileID = self.iconTextureFileID or TextureFileIDGet(self.iconObjectType, self.iconObjectID)
    self.instance.background:TextureSet(self.iconTextureFileID)

    if self.TextValueListenerGroup ~= nil then
        self.instance.text = self.instance.text or FontStringCreate(self.instance)
        self.instance.text:StyleSet("OVERLAY", FontTemplate, "CENTER")
        self.TextValueListenerGroup:Activate()
    end
end

function this:Demodify(frame)
    if self.TextValueListenerGroup ~= nil then
        self.TextValueListenerGroup:Deactivate()
        self.instance.text:SetText(nil)
    end

    frame.context.background:TextureSet(nil)
    frame.context:Release()
    frame.context = nil
    self.instance = nil
end

function this:OnNotify(event, value)
    self.instance.text:SetText(value)
end