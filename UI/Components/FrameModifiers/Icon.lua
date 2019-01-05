TheEyeAddon.UI.Components.Icon = {}
local this = TheEyeAddon.UI.Components.Icon
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local DisplayerAdd = TheEyeAddon.Managers.Icons.DisplayerAdd
local DisplayerRemove = TheEyeAddon.Managers.Icons.DisplayerRemove
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create
local TextureFileIDGet = TheEyeAddon.Helpers.Files.TextureFileIDGet


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = nil
    ListenerGroup = nil
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

	instance.ValueHandler = { validKeys = { [0] = true, } }

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify

    inherited.Setup(
        instance,
        "background",
        "creator"
    )
end

function this:Modify(frame)
    frame.background = frame.background or TextureCreate(frame, "BACKGROUND")
    self.iconTextureFileID = self.iconTextureFileID or TextureFileIDGet(self.iconObjectType, self.iconObjectID)
    frame.background:TextureSet(self.iconTextureFileID)

    DisplayerAdd(self.iconObjectID, self.UIObject.instanceType)
end

function this:Demodify(frame)
    frame.background:TextureSet(nil)

    DisplayerRemove(self.iconObjectID, self.UIObject.instanceType)
end