TheEyeAddon.Managers.Options = {}
local this = TheEyeAddon.Managers.Options

local locale = LibStub("AceLocale-3.0"):GetLocale("TheEyeAddon", true)
local moduleNames =
{
    active = "ACTIVE",
    cooldown = "COOLDOWN",
    rotation = "ROTATION",
    situational = "SITUATIONAL",
    targetFrame = "TARGET_FRAME",
}
local xPosition = 0
local yPosition = -50


function this.XPositionGet(info)
    local characterSettings = TheEyeAddon.Managers.Settings.Character
    return characterSettings.Saved.UI.Offset.X or characterSettings.Default.UI.Offset.X
end

function this.XPositionSet(info, value)
    local frame = TheEyeAddon.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetX = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )

    TheEyeAddon.Managers.Settings.Character.Saved.UI.Offset.X = value
end

function this.YPositionGet(info)
    local characterSettings = TheEyeAddon.Managers.Settings.Character
    return characterSettings.Saved.UI.Offset.Y or characterSettings.Default.UI.Offset.Y
end

function this.YPositionSet(info, value)
    local frame = TheEyeAddon.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetY = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )

    TheEyeAddon.Managers.Settings.Character.Saved.UI.Offset.Y = value
end

function this.SizeGet(info)
    local characterSettings = TheEyeAddon.Managers.Settings.Character
    return characterSettings.Saved.UI.scale or characterSettings.Default.UI.scale
end

function this.SizeSet(info, value)
    TheEyeAddon.Managers.UI.scale = value
    TheEyeAddon.Managers.Settings.Character.Saved.UI.scale = value
end

function this.EnabledGet(info)
    local moduleName = moduleNames[info[#info - 1]]
    return TheEyeAddon.Managers.Settings.Character.Saved.UI.Modules[moduleName].enabled
end

function this.EnabledSet(info, value)
    local moduleName = moduleNames[info[#info - 1]]
    TheEyeAddon.Managers.Settings.Character.Saved.UI.Modules[moduleName].enabled = value
end

function this.MaxIconsGet(info)
    local moduleName = moduleNames[info[#info - 1]]
    return TheEyeAddon.Managers.Settings.Character.Saved.UI.Modules[moduleName].maxIcons
end

function this.MaxIconsSet(info, value)
    local moduleName = moduleNames[info[#info - 1]]
    TheEyeAddon.Managers.UI.Modules.IconGroups[moduleName].UIObject.Group.maxDisplayedChildren = value
    TheEyeAddon.Managers.Settings.Character.Saved.UI.Modules[moduleName].maxIcons = value
end


this.options =
{
    name = "TheEye.Addon",
    type = "group",
    args =
    {
        general =
        {
            type = "group",
            name = "General",
            order = 1,
            inline = true,
            args =
            {
                position =
                {
                    type = "group",
                    name = locale["Position"],
                    order = 1,
                    inline = true,
                    args =
                    {
                        x =
                        {
                            type = "range",
                            name = "X",
                            desc = locale["Negative: Left | Positive: Right"],
                            get = this.XPositionGet,
                            set = this.XPositionSet,
                            min = -2000,
                            max = 2000,
                            softMin = -500,
                            softMax = 500,
                            step = 1,
                        },
                        y =
                        {
                            type = "range",
                            name = "Y",
                            desc = locale["Negative: Down | Positive: Up"],
                            get = this.YPositionGet,
                            set = this.YPositionSet,
                            min = -2000,
                            max = 2000,
                            softMin = -500,
                            softMax = 500,
                            step = 1,
                        },
                    },
                },
                size =
                {
                    type = "range",
                    name = locale["Size"],
                    order = 2,
                    get = this.SizeGet,
                    set = this.SizeSet,
                    min = 0.75,
                    max = 1.25,
                    step = 0.05,
                },
            },
        },
        modules =
        {
            type = "group",
            name = locale["Modules"],
            order = 2,
            inline = true,
            args =
            {
                active =
                {
                    type = "group",
                    name = locale["Active"],
                    order = 1,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                        maxIcons =
                        {
                            type = "range",
                            name = locale["Max Icons"],
                            order = 2,
                            get = this.MaxIconsGet,
                            set = this.MaxIconsSet,
                            min = 1,
                            max = 10,
                            step = 1,
                        },
                    },
                },
                cooldown =
                {
                    type = "group",
                    name = locale["Cooldown"],
                    order = 2,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                        maxIcons =
                        {
                            type = "range",
                            name = locale["Max Icons"],
                            order = 2,
                            get = this.MaxIconsGet,
                            set = this.MaxIconsSet,
                            min = 1,
                            max = 10,
                            step = 1,
                        },
                    },
                },
                rotation =
                {
                    type = "group",
                    name = locale["Rotation"],
                    order = 3,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                        maxIcons =
                        {
                            type = "range",
                            name = locale["Max Icons"],
                            order = 2,
                            get = this.MaxIconsGet,
                            set = this.MaxIconsSet,
                            min = 1,
                            max = 10,
                            step = 1,
                        },
                    },
                },
                situational =
                {
                    type = "group",
                    name = locale["Situational"],
                    order = 4,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                        maxIcons =
                        {
                            type = "range",
                            name = locale["Max Icons"],
                            order = 2,
                            get = this.MaxIconsGet,
                            set = this.MaxIconsSet,
                            min = 1,
                            max = 10,
                            step = 1,
                        },
                    },
                },
                targetAction =
                {
                    type = "group",
                    name = locale["Target Action"],
                    order = 4,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                    },
                },
                targetFrame =
                {
                    type = "group",
                    name = locale["Target Frame"],
                    order = 4,
                    inline = true,
                    args =
                    {
                        enabled =
                        {
                            type = "toggle",
                            name = locale["Enabled"],
                            desc = locale["Requires reload"],
                            order = 1,
                            get = this.EnabledGet,
                            set = this.EnabledSet,
                        },
                    },
                },
            },
        },
    },
}

LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TheEyeAddon", this.options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TheEyeAddon", "TheEye.Addon")