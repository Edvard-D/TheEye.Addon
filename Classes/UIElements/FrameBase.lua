TheEyeAddon.UIElements.FrameBase = {}

function TheEyeAddon.Frames.FrameBase:Create()
	local instance = {}
	setmetatable(instance, TheEyeAddon.UIElements.FrameBase)
	self.__index = self

	return instance
end