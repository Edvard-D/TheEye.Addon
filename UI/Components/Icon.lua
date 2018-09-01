TheEyeAddon.UI.Components.Icon = {}
local this = TheEyeAddon.UI.Components.Icon
local inherited = TheEyeAddon.UI.Components.FrameModifier

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture
local select = select
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create


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

local function GetIconTextureFileID(self)
	local fileID = nil

	if self.iconObjectType == "SPELL" then
		fileID = GetSpellTexture(self.iconObjectID)
	elseif self.iconObjectType == "ITEM" then
		fileID = select(10, GetItemInfo(self.iconObjectID))
	else
		error("No case exists for an iconObjectType of " ..
		tostring(self.iconObjectType) ..
		". iconObjectID passed: " ..
		tostring(self.iconObjectID) ..
		".")
		return
	end

	return fileID
end

function this:Modify(frame)
    TheEyeAddon.Managers.Debug.LogEntryAdd("TheEyeAddon.UI.Components.Icon", "Modify", self.UIObject, self)
    
    frame.background = frame.background or TextureCreate(frame, "BACKGROUND")
    self.iconTextureFileID = self.iconTextureFileID or GetIconTextureFileID(self)
    frame.background:TextureSet(self.iconTextureFileID)
end

function this:Demodify(frame)
    TheEyeAddon.Managers.Debug.LogEntryAdd("TheEyeAddon.UI.Components.Icon", "Demodify", self.UIObject, self)
    frame.background:TextureSet(nil)
end