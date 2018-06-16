local TheEyeAddon = TheEyeAddon


TheEyeAddon.Initializer = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", UIParent, nil, nil)
TheEyeAddon.Initializer:RegisterEvent("ADDON_LOADED")
TheEyeAddon.Initializer:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")


local function OnEvent(event, arg1)
    local _, class, _ = UnitClass("player")
    local spec = GetSpecialization()

    if class == "PRIEST" then
        if event == "ACTIVE_TALENT_GROUP_CHANGED" or
        (event == "ADDON_LOADED" and arg1 == "TheEye.Addon") then
            if spec == 3 then
                TheEyeAddon.UI.Builder:Initialize()
            else
                --TODO: disable addon
            end
        end
    end
end


TheEyeAddon.Initializer:SetScript("OnEvent", OnEvent)