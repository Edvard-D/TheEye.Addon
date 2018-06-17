local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Icon = {}

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture
local Pool = {}


local function GetIconTextureFileID(iconObjectType, iconObjectID)
	local fileID = nil

	if iconObjectType == TheEyeAddon.UI.Objects.IconObjectType.spell then
		fileID = GetSpellTexture(iconObjectID)
		if fileID == nil then
			error("Could not find a spell with an ID of " ..
			tostring(iconObjectID) ..
			".")
			return
		end
	elseif iconObjectType == TheEyeAddon.UI.Objects.IconObjectType.item then
		local _, _, _, _, _, _, _, _, _, fileID = GetItemInfo(iconObjectID)
		if fileID == nil then
			error("Could not find an item with an ID of " ..
			tostring(iconObjectID) ..
			".")
			return
		end
	else
		error("No IconObjectType exists with a value of " ..
		tostring(iconObjectType) ..
		". iconObjectID passed: " ..
		tostring(iconObjectID) ..
		".")
		return
	end

	return fileID
end

local function Claim(parentFrame, dimensionTable)
	local instance = nil
	for i,frame in ipairs(Pool) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Objects.Factories.Frame:SetDimensions(instance, dimensionTable)
	else
		instance = TheEyeAddon.UI.Objects.Factories.Cooldown:Create(parentFrame, dimensionTable)
	end

	instance.isClaimed = true
	return instance
end


function TheEyeAddon.UI.Objects.Factories.Icon:ClaimAndSetup(parentFrame, displayData)
	local instance = Claim(parentFrame, displayData.dimensionTable)

	local iconTextureFileID = GetIconTextureFileID(displayData.iconObjectType, displayData.iconObjectID)
	instance.texture = TheEyeAddon.UI.Objects.Factories.Texture:Create(instance, "BACKGROUND", iconTextureFileID)

	if displayData.isTextDisplay == true then
		instance.text = TheEyeAddon.UI.Objects.Factories.FontString:Create(instance, "OVERLAY", displayData.text, displayData.fontTemplate)
	end

	return instance
end