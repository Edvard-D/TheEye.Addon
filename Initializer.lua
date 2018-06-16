local TheEyeAddon = TheEyeAddon


TheEyeAddon.Initializer = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", UIParent, nil, nil)
TheEyeAddon.Initializer:RegisterEvent("ADDON_LOADED")


local function OnAddonLoaded(event, addonName)
    if addonName == "TheEye.Addon" then
        TheEyeAddon.UI.Builder:Initialize()
    end
end


TheEyeAddon.Initializer:SetScript("OnEvent", OnAddonLoaded)