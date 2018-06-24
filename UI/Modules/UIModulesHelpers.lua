local TheEyeAddon = TheEyeAddon

local pairs = pairs
local table = table
local type = type


local function SetupModule(module)
    module.frame = module.frame or TheEyeAddon.UI.Factories.Frame:Create("Frame", TheEyeAddon.UI.ParentFrame, nil, module.dimensionTemplate)

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
    for k,v in pairs(TheEyeAddon.UI.Modules) do
        if type(TheEyeAddon.UI.Modules[k]) == "table" and
        (TheEyeAddon.Settings == nil or table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, k) == false) then
            SetupModule(TheEyeAddon.UI.Modules[k])
        end
    end
end

function TheEyeAddon.UI.Modules:Teardown()
    for k,v in pairs(TheEyeAddon.UI.Modules) do
        if type(TheEyeAddon.UI.Modules[k]) == "table" and
        (TheEyeAddon.Settings == nil or table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, k) == false) then
            TeardownModule(TheEyeAddon.UI.Modules[k])
        end
    end
end