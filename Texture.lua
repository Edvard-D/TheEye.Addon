TheEyeAddon.Frames.Texture = {}

function TheEyeAddon.Frames.Texture:Create(instance, parentFrame)
	instance = instance or
	{
		frame = TheEyeAddon.Frames.FrameBase("Texture", nil, parentFrame)
	}
	setmetatable(instance, TheEyeAddon.Frames.Texture)
	self.__index = self

	return instance
end