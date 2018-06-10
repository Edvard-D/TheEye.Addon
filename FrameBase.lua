_TEA = TheEyeAddon
_TEA.UIObjects.FrameBase = {}


function _TEA.UIObjects.FrameBase:Create(instance, frameType, frameName, parentFrame)
	instance = instance or
	{
		"frame" = CreateFrame(frameType, frameName, parentFrame)
	}
	setmetatable(instance, _TEA.UIObjects.FrameBase)
	self.__index = self

	return instance
end