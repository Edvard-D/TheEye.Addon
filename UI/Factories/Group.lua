TheEyeAddon.UI.Factories.Group = {}
local this = TheEyeAddon.UI.Factories.Group

local Pool = TheEyeAddon.Managers.FramePools.Create("Group")


function this.Claim(uiObject, parentFrame, displayData)
	return Pool:Claim(uiObject, "Frame", parentFrame, nil, displayData)
end