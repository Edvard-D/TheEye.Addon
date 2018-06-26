local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Pools = {}

local ipairs = ipairs
local table = table


function TheEyeAddon.UI.Pools:Release()
	self.Hide()
	self.SetParent(nil)
	self.isClaimed = false
end

function TheEyeAddon.UI.Pools:Claim(frameType, parentKey, template, dimensionTemplate)
	local instance = nil
	for i,frame in ipairs(self.instances) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	local parentFrame
	if parentKey ~= nil then
		parentFrame = TheEyeAddon.UI.Objects[parentKey].frame
	else
		parentFrame = UIParent
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, dimensionTemplate)
	else
		instance = TheEyeAddon.UI.Factories.Frame:Create("Frame", parentFrame, nil, dimensionTemplate)
		instance.Release = TheEyeAddon.UI.Pools.Release
		table.insert(self, instance)
	end

	instance.isClaimed = true
	instance:Show()

	return instance
end

function TheEyeAddon.UI.Pools:Create()
	local instance = { Claim = TheEyeAddon.UI.Pools.Claim, instances = {} }
    table.insert(TheEyeAddon.UI.Pools, instance)
    return instance
end