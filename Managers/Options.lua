TheEye.Core.Managers.Options = {}
local this = TheEye.Core.Managers.Options

local locale = LibStub("AceLocale-3.0"):GetLocale("TheEye.Core", true)

local moduleNames = {}
local options =
{
    name = "TheEye",
    type = "group",
    args = {},
}


function this.Initialize()
    this.gameEvents = { "ADDON_LOADED" }
    TheEye.Core.Managers.Events.Register(this)
end

function this:OnEvent(event, addon)
    if addon == "TheEyeCore" then
        LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TheEye", options)
        LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TheEye")
    end
end

function this.TreeGroupAdd(key, value, newModuleNames)
    options.args[key] = value

    if newModuleNames ~= nil then
        for k,v in pairs(newModuleNames) do
            moduleNames[k] = v
        end
    end
end

function this.XPositionGet(info)
    return _G["TheEyeCharacterSettings"].UI.Offset.X or TheEye.Core.Managers.Settings.Character.Default.UI.Offset.X
end

function this.XPositionSet(info, value)
    local frame = TheEye.Core.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetX = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )

    _G["TheEyeCharacterSettings"].UI.Offset.X = value
end

function this.YPositionGet(info)
    return _G["TheEyeCharacterSettings"].UI.Offset.Y or TheEye.Core.Managers.Settings.Character.Default.UI.Offset.Y
end

function this.YPositionSet(info, value)
    local frame = TheEye.Core.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetY = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )
    
    _G["TheEyeCharacterSettings"].UI.Offset.Y = value
end

function this.SizeGet(info)
    return _G["TheEyeCharacterSettings"].UI.scale or TheEye.Core.Managers.Settings.Character.Default.UI.scale
end

function this.ExtraAbilityXPositionGet(info)
    return _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.X or TheEye.Core.Managers.Settings.Character.Default.UI.ExtraAbilityOffset.X
end

function this.ExtraAbilityXPositionSet(info, value)
    ExtraAbilityContainer:ClearAllPoints()
    x = value
    y = _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.Y or TheEye.Core.Managers.Settings.Character.Default.UI.ExtraAbilityOffset.Y
    ExtraAbilityContainer:SetPoint("CENTER", UIParent, "BOTTOM", x, y)

    _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.X = value
end

function this.ExtraAbilityYPositionGet(info)
    return _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.Y or TheEye.Core.Managers.Settings.Character.Default.UI.ExtraAbilityOffset.Y
end

function this.ExtraAbilityYPositionSet(info, value)    
    ExtraAbilityContainer:ClearAllPoints()
    x = _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.X or TheEye.Core.Managers.Settings.Character.Default.UI.ExtraAbilityOffset.X
    y = value
    ExtraAbilityContainer:SetPoint("CENTER", UIParent, "BOTTOM", x, y)

    _G["TheEyeCharacterSettings"].UI.ExtraAbilityOffset.Y = value
end

function this.SizeSet(info, value)
    TheEye.Core.Managers.UI.scale = value
    _G["TheEyeCharacterSettings"].UI.scale = value
end

function this.HideActionBarDuringCombatGet(info)
    return _G["TheEyeCharacterSettings"].UI.ShouldHideActionBarDuringCombat
end

function this.HideActionBarDuringCombatSet(info, value)
    _G["TheEyeCharacterSettings"].UI.ShouldHideActionBarDuringCombat = value
end

function this.EnabledGet(info)
    local moduleName = moduleNames[info[#info - 1]]
    return _G["TheEyeCharacterSettings"].UI.Modules[moduleName].enabled
end

function this.EnabledSet(info, value)
    local moduleName = moduleNames[info[#info - 1]]
    _G["TheEyeCharacterSettings"].UI.Modules[moduleName].enabled = value
end

function this.LongCooldownsGet(info)
    local moduleName = moduleNames[info[#info - 1]]
    return _G["TheEyeCharacterSettings"].UI.Modules[moduleName].isLongCooldownsOnly
end

function this.LongCooldownsSet(info, value)
    local moduleName = moduleNames[info[#info - 1]]
    _G["TheEyeCharacterSettings"].UI.Modules[moduleName].isLongCooldownsOnly = value
end

function this.MaxIconsGet(info)
    local moduleName = moduleNames[info[#info - 1]]
    return _G["TheEyeCharacterSettings"].UI.Modules[moduleName].maxIcons
end

function this.MaxIconsSet(info, value)
    local moduleName = moduleNames[info[#info - 1]]
    TheEye.Core.Managers.UI.Modules.IconGroups[moduleName].UIObject.Group.maxDisplayedChildren = value
    _G["TheEyeCharacterSettings"].UI.Modules[moduleName].maxIcons = value
end