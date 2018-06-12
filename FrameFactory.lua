local TEA = TheEyeAddon
TEA.UIObjects.FrameFactory = {}

local CreateFrame = CreateFrame


function TEA.UIObjects.FrameFactory:Create(frameType, frameName, parentFrame)
	local instance = CreateFrame(frameType, frameName, parentFrame)

	return instance
end