local TEA = TheEyeAddon
TEA.UI.Objects.Factories.Icon = {}

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture


local function GetIconTextureFileID(iconObjectType, iconObjectID)
	local fileID = nil

	if iconObjectType == TEA.UI.Objects.IconObjectType.spell then
		fileID = GetSpellTexture(iconObjectID)
		if fileID == nil then
			error("Could not find a spell with an ID of " ..
			tostring(iconObjectID) ..
			".")
			return
		end
	elseif iconObjectType == TEA.UI.Objects.IconObjectType.item then
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


function TheEyeAddon.UI.Objects.Factories.Icon:Create(
	parentFrame,
	width, height,
	point, relativePoint, offsetX, offsetY,
	iconObjectType, iconObjectID,
	isTextDisplay, text, fontTemplate,
	isCooldownDisplay, isReversed)

	local instance = TEA.UI.Objects.Factories.Frame:Create(
		"Frame", parentFrame,
		width, height,
		point, relativePoint, offsetX, offsetY)

	local iconTextureFileID = GetIconTextureFileID(iconObjectType, iconObjectID)
	instance.texture = TEA.UI.Objects.Factories.Texture:Create(instance, "ARTWORK", iconTextureFileID)

	if isTextDisplay == true then
		instance.text = TEA.UI.Objects.Factories.FontString:Create(instance, "OVERLAY", text, fontTemplate)
	end

	if isCooldownDisplay == true then
		instance.cooldown = TEA.UI.Objects.Factories.Cooldown:Create(instance, width, height, isReversed)
	end

	return instance
end