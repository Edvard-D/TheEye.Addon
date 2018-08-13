TheEyeAddon.UI.Factories.FontString = {}
local this = TheEyeAddon.UI.Factories.FontString


function this.Create(parentFrame, layer, text, fontTemplate)
	local instance = parentFrame:CreateFontString(nil, layer)
	
	fontTemplate.SetFont(instance)
	instance:SetText(text)
	instance:SetPoint("CENTER", parentFrame, "CENTER", 0, 0)
	
	return instance
end