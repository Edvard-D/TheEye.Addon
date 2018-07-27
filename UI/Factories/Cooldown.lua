TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local Pool = TheEyeAddon.UI.Pools.Create()


function this.Claim(uiObject, parentFrame, displayData)
	local dimensionTemplate = nil
	if displayData ~= nil then
		dimensionTemplate = displayData.DimensionTemplate
	end
	local instance = Pool:Claim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", dimensionTemplate)	
	return instance
end