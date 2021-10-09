TheEye.Core.UI.Factories.Frame = {}
local this = TheEye.Core.UI.Factories.Frame

local CreateFrame = CreateFrame
local frameTypes =
{
	CastBar = "Frame",
	Cooldown = "Cooldown",
	Frame = "Frame",
    Model = "PlayerModel",
	TargetFrame = "Frame",
}
local minSize = TheEye.Core.Data.frameMinSize
local SendCustomEvent = TheEye.Core.Managers.Events.SendCustomEvent


function this.Create(uiObject, frameType, parentFrame, inheritsFrom, dimensions)
	local instance = CreateFrame(frameTypes[frameType], nil, parentFrame or UIParent, inheritsFrom)

	instance.UIObject = uiObject
	instance.SetSizeWithEvent = this.SetSizeWithEvent

	this.SetDimensions(instance, dimensions)
	
	return instance
end

function this.SetDimensions(frame, dimensions)
	if dimensions ~= nil then
		frame:SetSize(dimensions.width or minSize, dimensions.height or minSize)
		if dimensions.PointSettings ~= nil then
			frame:SetPoint(
				dimensions.PointSettings.point,
				frame:GetParent(),
				dimensions.PointSettings.relativePoint,
				dimensions.PointSettings.offsetX or 0,
				dimensions.PointSettings.offsetY or 0)
		else
			frame:SetAllPoints()
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

		if self.UIObject ~= nil then
			SendCustomEvent("UIOBJECT_FRAME_DIMENSIONS_CHANGED", self.UIObject)
		end
	end
end