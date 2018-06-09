TheEyeAddon.Frames.Icon = {}

function TheEyeAddon.Frames.Icon:Create(instance, frameName, parentFrame)
	-- TODO: assign frameType
	
	instance = instance or
	{
		frame = TheEyeAddon.Frames.FrameBase(frameType, frameName, parentFrame)
	}
	setmetatable(instance, TheEyeAddon.Frames.Icon)
	self.__index = self

	return instance
end