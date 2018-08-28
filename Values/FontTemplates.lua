TheEyeAddon.Values.FontTemplates = {}
local this = TheEyeAddon.Values.FontTemplates


this.Icon = {}
local Icon = this.Icon

Icon.default =
{
    SetFont = function(fontInstance)
        fontInstance:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
    end
}

Icon.context =
{
    SetFont = function(fontInstance)
        fontInstance:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
    end
}