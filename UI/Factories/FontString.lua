local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.FontString = {}


function TheEyeAddon.UI.Factories.FontString:Create(parentFrame, layer, text, fontTemplate)
	local instance = parentFrame:CreateFontString(nil, layer)
	
	fontTemplate.SetFont(instance)
	instance:SetText(text)
	instance:SetPoint("CENTER", parentFrame, "CENTER", 0, 0)
	
	return instance
end