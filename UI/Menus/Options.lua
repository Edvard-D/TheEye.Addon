TheEyeAddon.Managers.Options = {}
local this = TheEyeAddon.Managers.Options

local locale = LibStub("AceLocale-3.0"):GetLocale("TheEyeAddon", true)
local xPosition = 0
local yPosition = -50


function this.XPositionGet(info)
    local characterSettings = TheEyeAddon.Managers.Settings.Character
    return characterSettings.Saved.uiParentOffset.X or characterSettings.Default.uiParentOffset.X
end

function this.XPositionSet(info, value)
    local frame = TheEyeAddon.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetX = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )

    TheEyeAddon.Managers.Settings.Character.Saved.uiParentOffset.X = value
end

function this.YPositionGet(info)
    local characterSettings = TheEyeAddon.Managers.Settings.Character
    return characterSettings.Saved.uiParentOffset.Y or characterSettings.Default.uiParentOffset.Y
end

function this.YPositionSet(info, value)
    local frame = TheEyeAddon.UI.Objects.Instances["UIPARENT"].Frame
    local pointSettings = frame.Dimensions.PointSettings
    pointSettings.offsetY = value
    frame.instance:SetPoint(
        pointSettings.point, UIParent, pointSettings.relativePoint,
        pointSettings.offsetX, pointSettings.offsetY
    )

    TheEyeAddon.Managers.Settings.Character.Saved.uiParentOffset.Y = value
end

function this.ValidateAsNumber(info, value)
    if tonumber(value) == nil then
        return locale["Number required"]
    else
        return true
    end
end


this.options =
{
    name = "TheEye.Addon",
    type = "group",
    args =
    {
        position =
        {
            type = "group",
            name = "Position",
            order = 1,
            inline = true,
            args =
            {
                x =
                {
                    type = "input",
                    name = "X",
                    desc = locale["Negative: Left | Positive: Right"],
                    get = this.XPositionGet,
                    set = this.XPositionSet,
                    validate = this.ValidateAsNumber,
                },
                y =
                {
                    type = "input",
                    name = "Y",
                    desc = locale["Negative: Down | Positive: Up"],
                    get = this.YPositionGet,
                    set = this.YPositionSet,
                    validate = this.ValidateAsNumber,
                },
            },
        },
    },
}

LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("TheEyeAddon", this.options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("TheEyeAddon", "TheEye.Addon")