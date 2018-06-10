local TEA = TheEyeAddon
TEA.UIObjects.Icon = {}

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture
local setmetatable = setmetatable


function TheEyeAddon.UIObjects.Icon:Create(instance, parentFrame, iconObjectType, iconObjectID)
	local iconTextureFileID = GetIconTextureFileID(iconObjectType, iconObjectID)
	
	local instance = instance or
	{
		frame = TEA.UIObjects.FrameBase:Create(nil, "Frame", nil, parentFrame),
		texture = TEA.UIObjects.Texture:Create(nil, parentFrame, "BACKGROUND", iconTextureFileID)
	}
	setmetatable(instance, TEA.UIObjects.Icon)
	self.__index = self

	return instance
end

local function GetIconTextureFileID(iconObjectType, iconObjectID)
	if iconObjectType == TEA.UIObjects.IconObjectType.Spell then
		return GetSpellTexture(iconObjectID)
	else if iconObjectType == TEA.UIObjects.IconObjectType.Skill then
		local _, _, _, _, _, _, _, _, _, fileID, ... = GetItemInfo(iconObjectID)
		return fileID
	else
		error("No IconObjectType exists with a value of " .. tostring(iconObjectType)".")
	end
end