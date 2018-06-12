local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Objects.Factories.Frame:Create(
	frameType, parentFrame, inheritsFrom,
	width, height,
	point, relativePoint, offsetX, offsetY)

	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)

	if width ~= nil and height ~= nil and
		point ~= nil and parentFrame ~= nil and relativePoint ~= nil and offsetX ~= nil and offsetY ~= nil then
		
		instance:SetWidth(width)
		instance:SetHeight(height)
		instance:SetPoint(point, parentFrame, relativePoint, offsetX, offsetY)
	else
		instance:SetAllPoints()
	end

	return instance
end