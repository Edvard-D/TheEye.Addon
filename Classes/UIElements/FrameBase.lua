TheEyeAddon.Frames.FrameBase = {}

function TheEyeAddon.Frames.FrameBase:Create()
	local instance = {}
	setmetatable(instance, TheEyeAddon.Frames.FrameBase)
	self.__index = self

	return instance
end