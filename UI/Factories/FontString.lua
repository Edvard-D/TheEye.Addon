TheEye.Core.UI.Factories.FontString = {}
local this = TheEye.Core.UI.Factories.FontString


function this.Create(parentFrame)
	local instance = parentFrame:CreateFontString()
	
	instance.StyleSet = this.StyleSet
	
	return instance
end

function this:StyleSet(layer, fontTemplate, point, relativeTo, relativePoint, xOffset, yOffset)
	self:SetDrawLayer(layer)

	if fontTemplate ~= nil then
		self:SetFont(fontTemplate.font, fontTemplate.size, fontTemplate.flags)
	end

	if point ~= nil then
		if relativeTo == nil and relativePoint == nil then
			self:SetPoint(point)
		elseif xOffset == nil and yOffset == nil then
			self:SetPoint(point, relativeTo, relativePoint)
		else
			self:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset)
		end
	end
end