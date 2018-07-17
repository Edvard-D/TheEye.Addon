TheEyeAddon.UI.Objects:Initialize()


-- Values
TheEyeAddon.Values.cooldownEndAlertLength = 0.75

TheEyeAddon.Values.screenSize =
{
    width = GetScreenWidth(),
    height = GetScreenHeight(),
}


-- Settings
if TheEyeAddon.Settings == nil then
    TheEyeAddon.Settings = {}
end

if TheEyeAddon.Settings.DisabledUIModules == nil then
    TheEyeAddon.Settings.DisabledUIModules = {}
end