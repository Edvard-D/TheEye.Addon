local TEA = TheEyeAddon
TEA.UI.Objects.Factories.Cooldown = {}

local setmetatable = setmetatable


function TEA.UI.Objects.Factories.Cooldown:Create(parentFrame, width, height, isReversed)
	local instance = TEA.UI.Objects.Factories.Frame:Create(
		"Cooldown", parentFrame,
		width, height,
		"CENTER", "CENTER", 0, 0)

	instance:SetReverse(isReversed)


	setmetatable(instance, TEA.UI.Objects.Cooldown)
	self.__index = self

	return instance
end