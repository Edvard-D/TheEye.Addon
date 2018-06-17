local TheEyeAddon = TheEyeAddon


local function SetupModule(module)
    module.frame = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", TheEyeAddon.UI.ParentFrame, nil, module.dimensionTemplate)

    for k,v in pairs(module.Components) do
        TheEyeAddon.UI.Modules.Components:SetupComponent(module, module.Components[k])
    end
end


function TheEyeAddon.UI.Modules:Initialize()
    for k,moduleData in pairs(TheEyeAddon.UI.Modules) do
        if table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, k) == false then
            SetupModule(moduleData)
        end
    end
end