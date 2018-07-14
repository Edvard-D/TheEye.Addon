local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Factories.Frame:Create(uiObject, frameType, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, UIParent, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithEvent = TheEyeAddon.UI.Factories.Frame.SetSizeWithEvent
	TheEyeAddon.UI.Factories.Frame.SetDimensions(instance, UIParent, dimensionTemplate)

	return instance
end

function TheEyeAddon.UI.Factories.Frame.SetDimensions(frame, parentFrame, dimensionTemplate)
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

function TheEyeAddon.UI.Factories.Frame:SetSizeWithEvent(width, height)
	if width < 0.0001 then width = 0.0001 end
	if height < 0.0001 then height = 0.0001 end

	if width ~= self:GetWidth() or height ~= self:GetHeight() then
		self:SetSize(width, height)
		TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_RESIZED" , self.UIObject)
	end
end