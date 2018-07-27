TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.UI.Pools.Create()


function this.Claim(uiObject, parentFrame, displayData)
	return Pool:Claim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", displayData)
end