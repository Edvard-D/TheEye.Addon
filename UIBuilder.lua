local TEA = TheEyeAddon
TEA.UIBuilder = {}

local setmetatable = setmetatable


function TEA.UIBuilder:Create(instance)
	local instance = instance or {}


	setmetatable(instance, TEA.UIBuilder)
	self.__index = self

	return instance
end