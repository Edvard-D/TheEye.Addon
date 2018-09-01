TheEyeAddon.Managers.FramePools = {}
local this = TheEyeAddon.Managers.FramePools

local table = table


function this:Release()
	self:Hide()
	self:SetParent(nil)
	self.isClaimed = false
	self.UIObject = nil
end

function this:Claim(uiObject, frameType, parentFrame, template, dimensions)
	local instance = nil
	for i = 1, #self.Instances do
		local frame = self.Instances[i]
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame or UIParent)
		instance.UIObject = uiObject
		TheEyeAddon.UI.Factories.Frame.SetDimensions(instance, dimensions)
	else
		instance = TheEyeAddon.UI.Factories.Frame.Create(uiObject, frameType, parentFrame, template, dimensions)
		instance.Release = this.Release
		table.insert(self.Instances, instance)
	end

	instance.isClaimed = true
	instance:Show()

	return instance
end

function this.Create(poolKey)
	local instance = { Claim = this.Claim, Instances = {} }
	this[poolKey] = instance
    return instance
end