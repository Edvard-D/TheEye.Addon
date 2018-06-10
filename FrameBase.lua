local TEA = TheEyeAddon
TEA.UIObjects.FrameBase = {}

local CreateFrame = CreateFrame
local setmetatable = setmetatable


function TEA.UIObjects.FrameBase:Create(frameType, frameName, parentFrame)
	local instance = CreateFrame(frameType, frameName, parentFrame)


	setmetatable(instance, TEA.UIObjects.FrameBase)
	self.__index = self

	return instance
end