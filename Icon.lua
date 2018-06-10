_TEA = TheEyeAddon
_TEA.Frames.Icon = {}


function TheEyeAddon.Frames.Icon:Create(instance, parentFrame)
	-- TODO: assign frameType
	
	instance = instance or
	{
		frame = _TEA.Frames.FrameBase(frameType, nil, parentFrame)
	}
	setmetatable(instance, _TEA.Frames.Icon)
	self.__index = self

	return instance
end