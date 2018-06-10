_TEA = TheEyeAddon
_TEA.Frames.Texture = {}


function _TEA.Frames.Texture:Create(instance, parentFrame)
	instance = instance or
	{
		frame = TheEyeAddon.Frames.FrameBase("Texture", nil, parentFrame)
	}
	setmetatable(instance, _TEA.Frames.Texture)
	self.__index = self

	return instance
end