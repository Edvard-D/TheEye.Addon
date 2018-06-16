local TheEyeAddon = TheEyeAddon


TheEyeAddon.Initializer = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", UIParent, nil, nil)
TheEyeAddon.Initializer:RegisterEvent("ADDON_LOADED")


local function OnEvent(event, addonName)
    local _, class, _ = UnitClass("player")
    local spec = GetSpecialization()
    if addonName == "TheEye.Addon" and class == "PRIEST" and spec == 3 then
        TheEyeAddon.UI.Builder:Initialize()
    end
end


TheEyeAddon.Initializer:SetScript("OnEvent", OnEvent)