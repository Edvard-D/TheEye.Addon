TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.UI.Pools:Create()


function this.Claim(uiObject, displayData, start, duration)
	local instance = Pool:Claim(uiObject, "Cooldown", "CooldownFrameTemplate", displayData.DimensionTemplate)

	instance:SetCooldown(start, duration)
	
	return instance
end