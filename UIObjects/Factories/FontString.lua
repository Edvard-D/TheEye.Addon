local TEA = TheEyeAddon
TEA.UIObjects.Factories.FontString = {}


function TEA.UIObjects.Factories.FontString:Create(parentFrame, layer, text)
	local instance = parentFrame:CreateFontString(nil, layer)

	instance:SetText(text)
	
	return instance
end