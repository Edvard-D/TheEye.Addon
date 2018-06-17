local TheEyeAddon = TheEyeAddon
TheEyeAddon.Initializer = {}


TheEyeAddon.UI.ParentFrame = TheEyeAddon.UI.Factories.Frame:Create("Frame", UIParent, nil, nil)
TheEyeAddon.UI.ParentFrame:RegisterEvent("ADDON_LOADED")
TheEyeAddon.UI.ParentFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")


function TheEyeAddon.Initializer:OnEvent(event, arg1)
    local _, class, _ = UnitClass("player")
    local previousSpec = TheEyeAddon.CurrentSpec
    TheEyeAddon.CurrentSpec = GetSpecialization()

    if class == "PRIEST" then
        if event == "ACTIVE_TALENT_GROUP_CHANGED" or
        (event == "ADDON_LOADED" and arg1 == "TheEyeAddon") then
            if TheEyeAddon.CurrentSpec == 3 then
                TheEyeAddon.UI.Modules:Setup()
            elseif previousSpec == 3 then
                TheEyeAddon.UI.Modules:Teardown()
            end
        end
    end
end


TheEyeAddon.UI.ParentFrame:SetScript("OnEvent", TheEyeAddon.Initializer.OnEvent)