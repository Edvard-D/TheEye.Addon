TheEyeAddon.UI.Factories.Frame = {}
local this = TheEyeAddon.UI.Factories.Frame

local CreateFrame = CreateFrame
local minSize = 0.0001
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


function this.Create(uiObject, frameType, inheritsFrom, dimensionTemplate)
	local parentFrame = UIParent
	if dimensionTemplate ~= nil
		and dimensionTemplate.PointSettings ~= nil
		and dimensionTemplate.PointSettings.parentFrame ~= nil
		then
		parentFrame = dimensionTemplate.PointSettings.parentFrame
	end
	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)

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
				dimensionTemplate.PointSettings.parentFrame or UIParent,
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