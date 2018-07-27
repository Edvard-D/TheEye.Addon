TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.UI.Pools.Create()


function this.Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Cooldown", "CooldownFrameTemplate", displayData)	
	return instance
end