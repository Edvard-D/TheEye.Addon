_TEA = TheEyeAddon
_TEA.UIObjects.Icon = {}


function TheEyeAddon.UIObjects.Icon:Create(instance, parentFrame)
	-- TODO: assign frameType
	
	instance = instance or
	{
		frame = _TEA.UIObjects.FrameBase:Create(frameType, nil, parentFrame)
	}
	setmetatable(instance, _TEA.UIObjects.Icon)
	self.__index = self

	return instance
end