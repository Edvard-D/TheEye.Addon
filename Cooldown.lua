local TEA = TheEyeAddon
TEA.UIObjects.Cooldown = {}

local setmetatable = setmetatable


function TEA.UIObjects.Cooldown:Create(instance, parentFrame, layer, isReversed)
	local instance = instance or
	{
		TEA.UIObjects.FrameBase:Create(nil, "Cooldown", nil, parentFrame)
	}
	instance:SetReverse(isReversed)


	setmetatable(instance, TEA.UIObjects.Cooldown)
	self.__index = self

	return instance
end