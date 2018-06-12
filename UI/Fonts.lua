local TEA = TheEyeAddon
TEA.UI.Fonts = {}


TEA.UI.Fonts.Icon = {}
TEA.UI.Fonts.Icon.Default =
{
    font = "Fonts\\MORPHEUS.TTF",
    size = 20,

    SetFont = function(fontInstance)
        fontInstance:SetFont(font, size)
    end
}