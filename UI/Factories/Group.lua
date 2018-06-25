local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local ipairs = ipairs
local Pool = {}
local table = table


local function Release()
	self.isClaimed = false
	self:SetParent(nil)
	self:Hide()
end


function TheEyeAddon.UI.Factories.Group:Claim(parentFrame, displayData)
	local instance = nil
	for i,frame in ipairs(Pool) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, displayData.dimensionTemplate)
	else
		instance = TheEyeAddon.UI.Factories.Frame:Create("Frame", parentFrame, nil, displayData.dimensionTemplate)
		table.insert(Pool, instance)
	end

	instance.isClaimed = true
	instance.Release = Release
	instance:Show()

	return instance
end