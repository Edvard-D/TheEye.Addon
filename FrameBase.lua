_TEA = TheEyeAddon
_TEA.Frames.FrameBase = {}


function _TEA.Frames.FrameBase:Create(instance, frameType, frameName, parentFrame)
	instance = instance or
	{
		"frame" = CreateFrame(frameType, frameName, parentFrame)
	}
	setmetatable(instance, _TEA.Frames.FrameBase)
	self.__index = self

	return instance
end