TheEyeAddon.UIElements.UIElementBase = {}

function TheEyeAddon.UIElements.UIElementBase:Create()
	local instance = {}
	setmetatable(instance, TheEyeAddon.UIElements.UIElementBase)
	self.__index = self

	return instance
end