local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.FontString = {}


function TheEyeAddon.UI.Objects.Factories.FontString:Create(instance, parentFrame, layer, text, fontTemplate)
	instance = instance or parentFrame:CreateFontString(nil, layer)
	
	fontTemplate.SetFont(instance)
	instance:SetText(text)
	instance:SetPoint("CENTER", parentFrame, "CENTER", 0, 0)
	
	return instance
end