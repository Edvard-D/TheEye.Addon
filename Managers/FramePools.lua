TheEyeAddon.Managers.FramePools = {}
local this = TheEyeAddon.Managers.FramePools

local EventsDeregister = TheEyeAddon.Managers.Events.Deregister
local FrameCreate = TheEyeAddon.UI.Factories.Frame.Create
local FrameSetDimensions = TheEyeAddon.UI.Factories.Frame.SetDimensions
local pendingDeclaim = {}
local pools = {}
local table = table


this.customEvents =
{
    "UPDATE",
}


function this.Initialize()
    TheEyeAddon.Managers.Events.Register(this)
end

function this:OnEvent()
	if #pendingDeclaim > 0 then
		for i = 1, #pendingDeclaim do
			pendingDeclaim[i].isClaimed = false
		end

		pendingDeclaim = nil
		pendingDeclaim = {}
	end
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
		FrameSetDimensions(instance, dimensions)
	else
		instance = FrameCreate(uiObject, frameType, parentFrame, template, dimensions)
		instance.Release = this.Release
		table.insert(pool, instance)
	end

	instance.isClaimed = true
	instance:Show()

	return instance
end

function this:Release()
	self:Hide()
	self:SetParent(nil)
	self:ClearAllPoints()
	self.UIObject = nil
	self:SetScale(1)
	
	if self.background ~= nil then
		self.background:SetDesaturated(nil)
	end

	EventsDeregister(self)

	table.insert(pendingDeclaim, self)
end