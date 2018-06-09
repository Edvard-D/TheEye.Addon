TheEyeAddon.Frames.FrameBase = {}

function TheEyeAddon.Frames.FrameBase:Create(instance, frameType, frameName, parentFrame)
	instance = instance or
	{
		"frame" = CreateFrame(frameType, frameName, parentFrame)
	}
	setmetatable(instance, TheEyeAddon.Frames.FrameBase)
	self.__index = self

	return instance
end