local TEA = TheEyeAddon
TEA.UIObjects.FontStringFactory = {}


function TEA.UIObjects.FontStringFactory:Create(parentFrame, layer, text)
	local instance = parentFrame:CreateFontString(nil, layer)

	instance:SetText(text)
	
	return instance
end