local TEA = TheEyeAddon
TEA.UIObjects.FrameBase = {}

local setmetatable = setmetatable


function TEA.UIObjects.FrameBase:Create(instance, frameType, frameName, parentFrame)
	local instance = instance or
	{
		CreateFrame(frameType, frameName, parentFrame)
	}


	setmetatable(instance, TEA.UIObjects.FrameBase)
	self.__index = self

	return instance
end