local TEA = TheEyeAddon
TEA.UI.Objects.Factories.Cooldown = {}


function TEA.UI.Objects.Factories.Cooldown:Create(parentFrame, width, height, isReversed)
	local instance = TEA.UI.Objects.Factories.Frame:Create(
		"Cooldown", parentFrame,
		width, height,
		"CENTER", "CENTER", 0, 0)

	instance:SetReverse(isReversed)

	return instance
end