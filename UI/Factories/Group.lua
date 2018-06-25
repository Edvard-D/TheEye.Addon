local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()


function TheEyeAddon.UI.Factories.Group:Claim(parentFrame, displayData)
	local instance = Pool:Claim("Frame", parentFrame, nil, displayData.dimensionTemplate)
	
	return instance
end