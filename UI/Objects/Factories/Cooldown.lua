local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Cooldown = {}


function TheEyeAddon.UI.Objects.Factories.Cooldown:Create(parentFrame, dimensionTable, isReversed)
	local instance = TheEyeAddon.UI.Objects.Factories.Frame:Create(
		"Cooldown", parentFrame, "CooldownFrameTemplate", dimensionTable)

	instance:SetReverse(isReversed)
	instance:SetDrawBling(false)
	instance:SetDrawEdge(false)

	return instance
end