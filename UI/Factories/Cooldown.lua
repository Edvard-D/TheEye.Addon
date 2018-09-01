TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim


function this.Claim(uiObject, parentFrame, dimensions)
	return FrameClaim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", dimensions)
end