local TEA = TheEyeAddon
TEA.UIObjects.Cooldown = {}

local setmetatable = setmetatable


function TEA.UIObjects.Cooldown:Create(parentFrame, isReversed)
	local instance = TEA.UIObjects.FrameBase:Create("Cooldown", nil, parentFrame)

	instance:SetReverse(isReversed)


	setmetatable(instance, TEA.UIObjects.Cooldown)
	self.__index = self

	return instance
end