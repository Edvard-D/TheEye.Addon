TheEyeAddon.Managers.FramePools = {}
local this = TheEyeAddon.Managers.FramePools

local pools = {}
local table = table


function this:Release()
	self:Hide()
	self:SetParent(nil)
	self:ClearAllPoints()
	self.isClaimed = false
	self.UIObject = nil
end

local function PoolGet(frameType)
	if pools[frameType] == nil then
		pools[frameType] = {}
	end

	return pools[frameType]
end

function this.FrameClaim(uiObject, frameType, parentFrame, template, dimensions)
	local instance = nil
	local pool = PoolGet(frameType)

	for i = 1, #pool do
		local frame = pool[i]
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
		table.insert(pool, instance)
	end

	instance.isClaimed = true
	instance:Show()

	return instance
end