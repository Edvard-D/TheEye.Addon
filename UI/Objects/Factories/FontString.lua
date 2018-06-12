local TEA = TheEyeAddon
TEA.UI.Objects.Factories.FontString = {}


function TEA.UI.Objects.Factories.FontString:Create(parentFrame, layer, text, fontTemplate)
	local instance = parentFrame:CreateFontString(nil, layer)

	fontTemplate.SetFont(instance)
	instance:SetText(text)
	
	return instance
end