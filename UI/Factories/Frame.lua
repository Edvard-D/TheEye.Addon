TheEyeAddon.UI.Factories.Frame = {}
local this = TheEyeAddon.UI.Factories.Frame

local CreateFrame = CreateFrame
local minSize = 0.0001
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent


function this.Create(uiObject, frameType, parentFrame, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, parentFrame or UIParent, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithEvent = this.SetSizeWithEvent
	this.SetDimensions(instance, dimensionTemplate)

	return instance
end

function this.SetDimensions(frame, dimensionTemplate)
	if dimensionTemplate ~= nil then
		frame:SetSize(dimensionTemplate.width or minSize, dimensionTemplate.height or minSize)
		if dimensionTemplate.PointSettings ~= nil then
			frame:SetPoint(
				dimensionTemplate.PointSettings.point,
				frame:GetParent(),
				dimensionTemplate.PointSettings.relativePoint,
				dimensionTemplate.PointSettings.offsetX or 0,
				dimensionTemplate.PointSettings.offsetY or 0)
		end
	else
		frame:SetSize(minSize, minSize)
		frame:SetAllPoints()
	end
end

function this:SetSizeWithEvent(width, height)
	if width < minSize then width = minSize end
	if height < minSize then height = minSize end

	if width ~= self:GetWidth() or height ~= self:GetHeight() then
		self:SetSize(width, height)
		SendCustomEvent("UIOBJECT_RESIZED" , self.UIObject)
	end
end