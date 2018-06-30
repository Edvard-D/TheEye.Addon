TheEyeAddon.UI.Objects:Initialize()


TheEyeAddon.Screen =
{
    width = GetScreenWidth(),
    height = GetScreenHeight(),
}


if TheEyeAddon.Settings == nil then
    TheEyeAddon.Settings = {}
end

if TheEyeAddon.Settings.DisabledUIModules == nil then
    TheEyeAddon.Settings.DisabledUIModules = {}
end