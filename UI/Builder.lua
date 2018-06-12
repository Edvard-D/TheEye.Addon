local TEA = TheEyeAddon
TEA.UI.Builder = {}

local UIParent = UIParent


function TEA.UI.Builder:Initialize()
	local mindFlayID = 15407
	local mindFlay = TEA.UI.Objects.Factories.Icon:Create(
		UIParent,
		50, 50,
		"CENTER", "CENTER", 0, 0,
		TEA.UI.Objects.IconObjectType.spell, mindFlayID,
		true, "TEST",
		false, nil)
end