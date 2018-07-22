local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Frame = {}
local this = TheEyeAddon.UI.Factories.Frame

local CreateFrame = CreateFrame
local SendCustomEvent = TheEyeAddon.Events.Coordinators.OnEvent.SendCustomEvent


function this:Create(uiObject, frameType, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, UIParent, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithEvent = this.SetSizeWithEvent
	this.SetDimensions(instance, UIParent, dimensionTemplate)

	return instance
end

function this.SetDimensions(frame, parentFrame, dimensionTemplate)
	if dimensionTemplate ~= nil then
		frame:SetSizeWithEvent(dimensionTemplate.width or 0, dimensionTemplate.height or 0)
		if dimensionTemplate.PointSettings ~= nil then
			frame:SetPoint(
				dimensionTemplate.PointSettings.point,
				parentFrame,
				dimensionTemplate.PointSettings.relativePoint,
				dimensionTemplate.PointSettings.offsetX or 0,
				dimensionTemplate.PointSettings.offsetY or 0)
		end
	else
		frame:SetAllPoints()
	end
end

function this:SetSizeWithEvent(width, height)
	if width < 0.0001 then width = 0.0001 end
	if height < 0.0001 then height = 0.0001 end

	if width ~= self:GetWidth() or height ~= self:GetHeight() then
		self:SetSize(width, height)
		SendCustomEvent("UIOBJECT_RESIZED" , self.UIObject)
	end
end