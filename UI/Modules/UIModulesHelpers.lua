local TheEyeAddon = TheEyeAddon


local function SetupModule(module)
    module.frame = module.frame or TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", TheEyeAddon.UI.ParentFrame, nil, module.dimensionTemplate)

    for k,v in pairs(module.Components) do
        TheEyeAddon.UI.Components:SetupComponent(module, module.Components[k])
    end
end

local function TeardownModule(module)
    for k,v in pairs(module.Components) do
        TheEyeAddon.UI.Components:TeardownComponent(module, module.Components[k])
    end
end


function TheEyeAddon.UI.Modules:Setup()
    for k,moduleData in pairs(TheEyeAddon.UI.Modules) do
        if table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, k) == false then
            SetupModule(moduleData)
        end
    end
end

function TheEyeAddon.UI.Modules:Teardown()
    for k,moduleData in pairs(TheEyeAddon.UI.Modules) do
        if table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, k) == false then
            TeardownModule(moduleData)
        end
    end
end