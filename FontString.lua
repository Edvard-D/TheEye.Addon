local TEA = TheEyeAddon
TEA.UIObjects.FontString = {}


function TEA.UIObjects.FontString:Create(instance, parentFrame, layer, text)
	local instance = instance or
	{
		parentFrame:CreateFontString(nil, layer)
	}
	instance:SetText(text)


	setmetatable(instance, TEA.UIObjects.FontString)
	self.__index = self

	return instance
end