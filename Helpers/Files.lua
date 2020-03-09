TheEye.Core.Helpers.Files = {}
local this = TheEye.Core.Helpers.Files


function this.TextureFileIDGet(iconObjectType, iconObjectID)
	local fileID = nil

	if iconObjectType == "SPELL" then
		fileID = GetSpellTexture(iconObjectID)
	elseif iconObjectType == "ITEM" then
		fileID = select(10, GetItemInfo(iconObjectID))
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