local TEA = TheEyeAddon
TEA.UIObjects.FrameFactory = {}

local CreateFrame = CreateFrame


function TEA.UIObjects.FrameFactory:Create(frameType, parentFrame)
	local instance = CreateFrame(frameType, nil, parentFrame)

	return instance
end