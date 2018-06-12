local TEA = TheEyeAddon
TEA.UI.Fonts.Templates = {}


TEA.UI.Fonts.Templates.Icon = {}
local Icon = TEA.UI.Fonts.Templates.Icon

Icon.Default =
{
    SetFont = function(fontInstance)
        fontInstance:SetFont("Fonts\\FRIZQT__.TTF", 20, nil)
    end
}