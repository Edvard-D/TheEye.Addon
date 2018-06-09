TheEyeAddon.Frames.FrameBase = {}

function TheEyeAddon.Frames.FrameBase:Create(frameType, frameName, parentFrame)
	local instance =
	{
		"frame" = CreateFrame(frameType, frameName, parentFrame)
	}
	setmetatable(instance, TheEyeAddon.Frames.FrameBase)
	self.__index = self

	return instance
end