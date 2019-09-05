TheEyeAddon.UI.Factories.Texture = {}
local this = TheEyeAddon.UI.Factories.Texture

local EventRegister = TheEyeAddon.Managers.Events.Register


function this.Create(parentFrame, layer, blendMode)
	instance = parentFrame:CreateTexture(nil, layer)
	instance.TextureSet = this.TextureSet
	instance.RotationStart = this.RotationStart

	blendMode = blendMode or "DISABLE"
	instance:SetBlendMode(blendMode)

	return instance
end

function this:TextureSet(fileID)
	self:SetTexture(fileID)
	self:SetAllPoints()
end

function this:RotationStart(rotationRate)
	self.currentRotation = 0
	self.rotationRate = rotationRate

	self.customEvents = { "UPDATE", }
    EventRegister(instance)
    self.OnEvent = this.OnEvent
end

function this:OnEvent(event)
	self.currentRotation = self.currentRotation + self.rotationRate
	self:SetRotation(self.currentRotation)
end