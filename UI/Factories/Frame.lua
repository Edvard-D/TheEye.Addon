local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Factories.Frame:Create(uiObject, frameType, parentFrame, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithEvent = TheEyeAddon.UI.Factories.Frame.SetSizeWithEvent
	TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, parentFrame, dimensionTemplate)

	return instance
end

function TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, parentFrame, dimensionTemplate)
	if dimensionTemplate ~= nil then
		instance:SetSizeWithEvent(dimensionTemplate.width or 0, dimensionTemplate.height or 0)
		if dimensionTemplate.PointSettings ~= nil then
			instance:SetPoint(
				dimensionTemplate.PointSettings.point,
				parentFrame,
				dimensionTemplate.PointSettings.relativePoint,
				dimensionTemplate.PointSettings.xOffset,
				dimensionTemplate.PointSettings.yOffset)
		end
	else
		instance:SetAllPoints()
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