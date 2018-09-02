TheEyeAddon.UI.Components.ContextIcon = {}
local this = TheEyeAddon.UI.Components.ContextIcon
local inherited = TheEyeAddon.UI.Components.FrameModifier

local ContextIconDimensionTemplate = TheEyeAddon.Values.DimensionTemplates.Icon.Context
local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create
local TextureFileIDGet = TheEyeAddon.Helpers.Files.TextureFileIDGet


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    iconObjectType = #ICON#TYPE#
    iconObjectID = #ICON#ID#
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
end

function this:Modify(frame)
    frame.context = FrameClaim(self.UIObject, "Frame", frame, nil, ContextIconDimensionTemplate)
    
    frame.context.background = frame.context.background or TextureCreate(frame.context, "BACKGROUND")
    self.iconTextureFileID = self.iconTextureFileID or TextureFileIDGet(self.iconObjectType, self.iconObjectID)
    frame.context.background:TextureSet(self.iconTextureFileID)
end

function this:Demodify(frame)
    frame.context.background:TextureSet(nil)
    frame.context:Release()
    frame.context = nil
end