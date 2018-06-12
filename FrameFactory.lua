local TEA = TheEyeAddon
TEA.UIObjects.FrameFactory = {}

local CreateFrame = CreateFrame


function TEA.UIObjects.FrameFactory:Create(
		frameType, parentFrame,
		width, height,
		point, relativePoint, offsetX, offsetY)

	local instance = CreateFrame(frameType, nil, parentFrame)

	instance:SetWidth(width)
	instance:SetHeight(height)

	instance:SetPoint(point, parentFrame, relativePoint, offsetX, offsetY)

	return instance
end