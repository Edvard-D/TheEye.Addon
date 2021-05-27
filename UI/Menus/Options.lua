local locale = LibStub("AceLocale-3.0"):GetLocale("TheEye.Core", true)
local options =
{
    type = "group",
    name = locale["Core"],
    order = 1,
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
                    get = TheEye.Core.Managers.Options.XPositionGet,
                    set = TheEye.Core.Managers.Options.XPositionSet,
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
                    get = TheEye.Core.Managers.Options.YPositionGet,
                    set = TheEye.Core.Managers.Options.YPositionSet,
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
            get = TheEye.Core.Managers.Options.SizeGet,
            set = TheEye.Core.Managers.Options.SizeSet,
            min = 0.75,
            max = 1.25,
            step = 0.05,
        },
        hideActionBarDuringCombat =
        {
            type = "toggle",
            name = locale["Hide action bar during combat"],
            desc = locale["Requires reload"],
            order = 3,
            get = TheEye.Core.Managers.Options.HideActionBarDuringCombatGet,
            set = TheEye.Core.Managers.Options.HideActionBarDuringCombatSet,
        },
        extraAbilityPosition =
        {
            type = "group",
            name = locale["Extra Ability Position"],
            order = 4,
            inline = true,
            args =
            {
                x =
                {
                    type = "range",
                    name = "X",
                    desc = locale["Negative: Left | Positive: Right"],
                    get = TheEye.Core.Managers.Options.ExtraAbilityXPositionGet,
                    set = TheEye.Core.Managers.Options.ExtraAbilityXPositionSet,
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
                    get = TheEye.Core.Managers.Options.ExtraAbilityYPositionGet,
                    set = TheEye.Core.Managers.Options.ExtraAbilityYPositionSet,
                    min = 0,
                    max = 2000,
                    softMin = 0,
                    softMax = 1000,
                    step = 1,
                },
            },
        },
    },
}


TheEye.Core.Managers.Options.TreeGroupAdd("core", options, nil)