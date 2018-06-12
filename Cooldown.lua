local TEA = TheEyeAddon
TEA.UIObjects.Cooldown = {}

local setmetatable = setmetatable


function TEA.UIObjects.Cooldown:Create(parentFrame, width, height, isReversed)
	local instance = TEA.UIObjects.FrameFactory:Create(
		"Cooldown", parentFrame,
		width, height,
		"CENTER", "CENTER", 0, 0)

	instance:SetReverse(isReversed)


	setmetatable(instance, TEA.UIObjects.Cooldown)
	self.__index = self

	return instance
end