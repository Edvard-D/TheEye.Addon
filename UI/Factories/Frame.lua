local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Frame = {}

local CreateFrame = CreateFrame


function TheEyeAddon.UI.Factories.Frame:Create(uiObject, frameType, parentFrame, inheritsFrom, dimensionTemplate)
	local instance = CreateFrame(frameType, nil, parentFrame, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithMessage = TheEyeAddon.UI.Factories.Frame.SetSizeWithMessage
	TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, parentFrame, dimensionTemplate)

	return instance
end

function TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, parentFrame, dimensionTemplate)
	if dimensionTemplate ~= nil then
		instance:SetSize(dimensionTemplate.width or 0, dimensionTemplate.height or 0)
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