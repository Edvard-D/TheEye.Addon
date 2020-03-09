TheEye.Core.UI.Factories.FontString = {}
local this = TheEye.Core.UI.Factories.FontString


function this.Create(parentFrame)
	local instance = parentFrame:CreateFontString()
	
	instance.StyleSet = this.StyleSet
	
	return instance
end

function this:StyleSet(layer, fontTemplate, point)
	self:SetDrawLayer(layer)

	if fontTemplate ~= nil then
		self:SetFont(fontTemplate.font, fontTemplate.size, fontTemplate.flags)
	end

	if point ~= nil then
		self:SetPoint(point)
	end
end