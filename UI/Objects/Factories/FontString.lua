local TEA = TheEyeAddon
TEA.UI.Objects.Factories.FontString = {}


function TEA.UI.Objects.Factories.FontString:Create(parentFrame, layer, text)
	local instance = parentFrame:CreateFontString(nil, layer)

	instance:SetText(text)
	
	return instance
end