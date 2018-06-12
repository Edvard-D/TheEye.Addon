local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Objects.Factories.Frame:Create(frameType, parentFrame, inheritsFrom, dimensionTemplate)

	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)

	if dimensionTemplate ~= nil then
		instance:SetWidth(dimensionTemplate.width)
		instance:SetHeight(dimensionTemplate.height)
		instance:SetPoint(
			dimensionTemplate.point,
			dimensionTemplate.parentFrame,
			dimensionTemplate.relativePoint,
			dimensionTemplate.offsetX,
			dimensionTemplate.offsetY)
	else
		instance:SetAllPoints()
	end

	return instance
end