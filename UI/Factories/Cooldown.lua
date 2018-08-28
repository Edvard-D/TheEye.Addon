TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.Managers.FramePools.Create("Cooldown")


function this.Claim(uiObject, parentFrame, displayData)
	return Pool:Claim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", displayData)
end