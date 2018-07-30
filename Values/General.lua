local this = TheEyeAddon.Values


this.castStartHideDelay = 0.5
this.cooldownEndAlertLength = 0.75

function this.CooldownAlertLengthGet()
    local cooldownEndAlertLength = select(2, GetSpellCooldown(61304)) -- GCD
    if cooldownEndAlertLength == 0 then
        cooldownEndAlertLength = 0.75
    end

    return cooldownEndAlertLength
end

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