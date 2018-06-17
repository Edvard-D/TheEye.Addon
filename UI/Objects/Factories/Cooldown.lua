local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Cooldown = {}

local Pool = {}


function TheEyeAddon.UI.Objects.Factories.Cooldown:Claim(parentFrame, displayData)
	local instance = nil
	for i,frame in ipairs(Pool) do
		if frame.isClaimed == false then
			instance = frame
			break
		end
	end

	if instance ~= nil then
		instance:SetParent(parentFrame)
		TheEyeAddon.UI.Objects.Factories.Frame:SetDimensions(instance, displayData.dimensionTable)
	else
		local instance = TheEyeAddon.UI.Objects.Factories.Frame:Create(
			"Cooldown", parentFrame, "CooldownFrameTemplate", displayData.dimensionTable)
	end


	instance.isClaimed = true

	instance:SetDrawBling(false)
	instance:SetDrawEdge(false)

	return instance
end