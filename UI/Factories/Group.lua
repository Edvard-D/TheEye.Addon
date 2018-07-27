TheEyeAddon.UI.Factories.Group = {}
local this = TheEyeAddon.UI.Factories.Group

local Pool = TheEyeAddon.UI.Pools:Create()


function this.Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", nil, displayData.DimensionTemplate)
	
	return instance
end