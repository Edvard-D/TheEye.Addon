local TheEyeAddon = TheEyeAddon
TheEyeAddon.Values = {}
this = TheEyeAddon.Values


this.castStartHideDelay = 0.5
this.cooldownEndAlertLength = 0.75

this.screenSize =
{
    width = GetScreenWidth(),
    height = GetScreenHeight(),
}

this.powerTypes =
{
    MANA = 0,
    INSANITY = 13,
}