TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()


function TheEyeAddon.UI.Factories.Group:Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", nil, displayData.DimensionTemplate)
	
	return instance
end