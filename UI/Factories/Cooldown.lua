local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Cooldown = {}


function TheEyeAddon.UI.Factories.Cooldown:Create(parentFrame, dimensionTable)
	local instance = TheEyeAddon.UI.Factories.Frame:Create(
		"Cooldown", parentFrame, "CooldownFrameTemplate", dimensionTable)

	instance:SetDrawBling(false)
	instance:SetDrawEdge(false)

	return instance
end