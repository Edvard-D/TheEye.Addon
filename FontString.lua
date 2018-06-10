local TEA = TheEyeAddon
TEA.UIObjects.FontString = {}

local setmetatable = setmetatable


function TEA.UIObjects.FontString:Create(parentFrame, layer, text)
	local instance = parentFrame:CreateFontString(nil, layer)

	instance:SetText(text)


	setmetatable(instance, TEA.UIObjects.FontString)
	self.__index = self
	
	return instance
end