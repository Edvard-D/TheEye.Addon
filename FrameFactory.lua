local TEA = TheEyeAddon
TEA.UIObjects.FrameFactory = {}

local CreateFrame = CreateFrame


function TEA.UIObjects.FrameFactory:Create(frameType, parentFrame, width, height)
	local instance = CreateFrame(frameType, nil, parentFrame)

	instance:SetWidth(width)
	instance:SetHeight(height)

	return instance
end