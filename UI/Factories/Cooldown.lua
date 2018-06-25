local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Cooldown = {}

local ipairs = ipairs
local Pool = {}
local table = table

function Release()
	self.isClaimed = false
	self:SetParent(nil)
	self:Hide()
end


function TheEyeAddon.UI.Factories.Cooldown:Create(parentFrame, start, duration)
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
		local instance = TheEyeAddon.UI.Factories.Frame:Create("Cooldown", parentFrame, "CooldownFrameTemplate")
		instance:SetDrawBling(false)
		instance:SetDrawEdge(false)
		table.insert(Pool, instance)
	end

	instance.isClaimed = true
	instance.Release = Release
	instance:Show()

	instance:SetCooldown(start, duration)

	return instance
end