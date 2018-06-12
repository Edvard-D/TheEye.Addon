local TEA = TheEyeAddon
TEA.UI.Fonts.Templates = {}


TEA.UI.Fonts.Templates.Icon = {}
TEA.UI.Fonts.Templates.Icon.Default =
{
    font = "Fonts\\MORPHEUS.TTF",
    size = 20,

    SetFont = function(fontInstance)
        fontInstance:SetFont(font, size)
    end
}