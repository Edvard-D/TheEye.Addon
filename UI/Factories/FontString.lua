TheEyeAddon.UI.Factories.FontString = {}
local this = TheEyeAddon.UI.Factories.FontString


function this.Create(parentFrame)
	local instance = parentFrame:CreateFontString()
	
	instance.StyleSet = this.StyleSet
	
	return instance
end

function this:StyleSet(layer, fontTemplate)
	self:SetDrawLayer(layer)
	self:SetFont(fontTemplate.font, fontTemplate.size, fontTemplate.flags)
end