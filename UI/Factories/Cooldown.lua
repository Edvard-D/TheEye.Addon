TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.Managers.FramePools.Create("Cooldown")


function this.Claim(uiObject, parentFrame, dimensions)
	return Pool:Claim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", dimensions)
end