local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Pools = {}

local ipairs = ipairs
local table = table


local function Claim(frameType, parentFrame, template, dimensionTable)
	local instance = nil
	for i,frame in ipairs(self) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Factories.Frame:SetDimensions(instance, dimensionTemplate)
	else
		instance = TheEyeAddon.UI.Factories.Frame:Create("Frame", parentFrame, nil, dimensionTemplate)
		table.insert(self, instance)
	end

	instance.isClaimed = true
	instance.Release = Release
	instance:Show()

	return instance
end