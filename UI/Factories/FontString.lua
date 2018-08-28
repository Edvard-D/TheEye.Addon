TheEyeAddon.UI.Factories.FontString = {}
local this = TheEyeAddon.UI.Factories.FontString


function this.Create(parentFrame, layer, fontTemplate)
	local instance = parentFrame:CreateFontString(nil, layer)
	
	fontTemplate.SetFont(instance)
	
	return instance
end