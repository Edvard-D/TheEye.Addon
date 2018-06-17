local TheEyeAddon = TheEyeAddon


TheEyeAddon.UI.ParentFrame = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", UIParent, nil, nil)
TheEyeAddon.UI.ParentFrame:RegisterEvent("ADDON_LOADED")
TheEyeAddon.UI.ParentFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")


local function OnEvent(event, arg1)
    local _, class, _ = UnitClass("player")
    local spec = GetSpecialization()

    if class == "PRIEST" then
        if event == "ACTIVE_TALENT_GROUP_CHANGED" or
        (event == "ADDON_LOADED" and arg1 == "TheEye.Addon") then
            if spec == 3 then
                TheEyeAddon.UI.Modules:Initialize()
            else
                --TODO: disable addon
            end
        end
    end
end


TheEyeAddon.UI.ParentFrame:SetScript("OnEvent", OnEvent)