TheEyeAddon.Frames.Icon = {}

function TheEyeAddon.Frames.Icon:Create(instance, parentFrame)
	-- TODO: assign frameType
	
	instance = instance or
	{
		frame = TheEyeAddon.Frames.FrameBase(frameType, nil, parentFrame)
	}
	setmetatable(instance, TheEyeAddon.Frames.Icon)
	self.__index = self

	return instance
end