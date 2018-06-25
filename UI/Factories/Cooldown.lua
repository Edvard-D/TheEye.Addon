local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Cooldown = {}

local Pool = TheEyeAddon.UI.Pools:Create()


function TheEyeAddon.UI.Factories.Cooldown:Claim(parentFrame, displayData, start, duration)
	local instance = Pool:Claim("Cooldown", parentFrame, "CooldownFrameTemplate", displayData.dimensionTemplate)

	instance:SetCooldown(start, duration)
	
	return instance
end