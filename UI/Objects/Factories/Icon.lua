local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Icon = {}

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture


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


function TheEyeAddon.UI.Objects.Factories.Icon:Create(
	parentFrame,
	width, height,
	point, relativePoint, offsetX, offsetY,
	iconObjectType, iconObjectID,
	isTextDisplay, text, fontTemplate,
	isCooldownDisplay, isReversed)

	local instance = TheEyeAddon.UI.Objects.Factories.Frame:Create(
		"Frame", parentFrame, nil,
		width, height,
		point, relativePoint, offsetX, offsetY)

	local iconTextureFileID = GetIconTextureFileID(iconObjectType, iconObjectID)
	instance.texture = TheEyeAddon.UI.Objects.Factories.Texture:Create(instance, "BACKGROUND", iconTextureFileID)

	if isTextDisplay == true then
		instance.text = TheEyeAddon.UI.Objects.Factories.FontString:Create(instance, "OVERLAY", text, fontTemplate)
	end

	if isCooldownDisplay == true then
		instance.cooldown = TheEyeAddon.UI.Objects.Factories.Cooldown:Create(instance, width, height, isReversed)
	end

	return instance
end