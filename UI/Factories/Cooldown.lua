local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Cooldown = {}

local Pool = TheEyeAddon.UI.Pools:Create()


function TheEyeAddon.UI.Factories.Cooldown:Claim(uiObject, displayData, start, duration)
	local instance = Pool:Claim(uiObject, "Cooldown", displayData.parentKey, "CooldownFrameTemplate", displayData.DimensionTemplate)

	instance:SetCooldown(start, duration)
	
	return instance
end