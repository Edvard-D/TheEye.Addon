local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()


function TheEyeAddon.UI.Factories.Group:Claim(displayData)
	local instance = Pool:Claim("Frame", displayData.parentKey, nil, displayData.DimensionTemplate)
	
	return instance
end