local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Icon = {}

local GetItemInfo = GetItemInfo
local GetSpellTexture = GetSpellTexture
local Pool = {}


local function GetIconTextureFileID(iconObjectType, iconObjectID)
	local fileID = nil

	if iconObjectType == "SPELL" then
		fileID = GetSpellTexture(iconObjectID)
		if fileID == nil then
			error("Could not find a spell with an ID of " ..
			tostring(iconObjectID) ..
			".")
			return
		end
	elseif iconObjectType == "ITEM" then
		local _, _, _, _, _, _, _, _, _, fileID = GetItemInfo(iconObjectID)
		if fileID == nil then
			error("Could not find an item with an ID of " ..
			tostring(iconObjectID) ..
			".")
			return
		end
	else
		error("No case exists for an iconObjectType of " ..
		tostring(iconObjectType) ..
		". iconObjectID passed: " ..
		tostring(iconObjectID) ..
		".")
		return
	end

	return fileID
end


function TheEyeAddon.UI.Factories.Icon:Claim(parentFrame, displayData)
	local instance = nil
	for i,frame in ipairs(Pool) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, displayData.dimensionTable)
	else
		instance = TheEyeAddon.UI.Factories.Cooldown:Create(parentFrame, displayData.dimensionTable)
		table.insert(Pool, instance)
	end


	instance.isClaimed = true
	instance.Release = TheEyeAddon.UI.Factories.Icon.Release
	instance:Show()

	local iconTextureFileID = GetIconTextureFileID(displayData.iconObjectType, displayData.iconObjectID)
	instance.texture = TheEyeAddon.UI.Factories.Texture:Create(instance.texture, instance, "BACKGROUND", iconTextureFileID)

	instance.text = TheEyeAddon.UI.Factories.FontString:Create(instance.text, instance, "OVERLAY", displayData.text, displayData.fontTemplate)

	return instance
end

function TheEyeAddon.UI.Factories.Icon:Release()
	self.isClaimed = false
	self:SetParent(nil)
	self:Hide()
end