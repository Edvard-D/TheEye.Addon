_TEA = TheEyeAddon
_TEA.UIObjects.Texture = {}


function _TEA.UIObjects.Texture:Create(instance, parentFrame)
	instance = instance or
	{
		frame = TheEyeAddon.UIObjects.FrameBase("Texture", nil, parentFrame)
	}
	setmetatable(instance, _TEA.UIObjects.Texture)
	self.__index = self

	return instance
end