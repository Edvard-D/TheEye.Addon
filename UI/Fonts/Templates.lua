local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Fonts.Templates = {}


TheEyeAddon.UI.Fonts.Templates.Icon = {}
local Icon = TheEyeAddon.UI.Fonts.Templates.Icon

Icon.Default =
{
    SetFont = function(fontInstance)
        fontInstance:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
    end
}