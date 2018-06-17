local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Factories.Frame:Create(frameType, parentFrame, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)
	TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, dimensionTemplate)
	return instance
end

function TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, dimensionTemplate)
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
end