local TEA = TheEyeAddon
TEA.UIBuilder = {}

local UIParent = UIParent


function TEA.UIBuilder:Initialize()
	local mindFlayID = 15407
	local mindFlay = TEA.UIObjects.Factories.Icon:Create(
		UIParent,
		50, 50,
		"CENTER", "CENTER", 0, 0,
		TEA.UIObjects.IconObjectType.Spell, mindFlayID,
		false, nil,
		false, nil)

	mindFlay:Show()
end