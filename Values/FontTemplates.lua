TheEyeAddon.Values.FontTemplates = {}


TheEyeAddon.Values.FontTemplates.Icon = {}
local Icon = TheEyeAddon.Values.FontTemplates.Icon

Icon.default =
{
    SetFont = function(fontInstance)
        fontInstance:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
    end
}