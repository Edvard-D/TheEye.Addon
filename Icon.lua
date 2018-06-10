_TEA = TheEyeAddon
_TEA.UIObjects.Icon = {}


function TheEyeAddon.UIObjects.Icon:Create(instance, parentFrame, iconObjectType, iconObjectID)
	local iconTextureFileID = GetIconTextureFileID(iconObjectType, iconObjectID)
	
	instance = instance or
	{
		frame = _TEA.UIObjects.FrameBase:Create("Frame", nil, parentFrame)
	}
	setmetatable(instance, _TEA.UIObjects.Icon)
	self.__index = self

	return instance
end

local function GetIconTextureFileID(iconObjectType, iconObjectID)
	if iconObjectType == _TEA.UIObjects.IconObjectType.Spell then
		return GetSpellTexture(iconObjectID)
	else if iconObjectType == _TEA.UIObjects.IconObjectType.Skill then
		local _, _, _, _, _, _, _, _, _, fileID, ... = GetItemInfo(iconObjectID)
		return fileID
	else
		error("No IconObjectType exists with a value of " .. tostring(iconObjectType)".")
	end
end