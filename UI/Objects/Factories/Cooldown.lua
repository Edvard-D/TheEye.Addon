local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Cooldown = {}


function TheEyeAddon.UI.Objects.Factories.Cooldown:Create(parentFrame, isReversed)
	local instance = TheEyeAddon.UI.Objects.Factories.Frame:Create(
		"Cooldown", parentFrame, "CooldownFrameTemplate")

	instance:SetReverse(isReversed)
	instance:SetDrawBling(false)
	instance:SetDrawEdge(false)

	return instance
end