local this = TheEyeAddon.Values


this.cooldownEndAlertLength = 0.75

function this.ReadySoonAlertLengthGet()
    local readySoonAlertLength = 0.75
    local gcdLength = 1.5 / ((UnitSpellHaste("player") / 100) + 1)
    if gcdLength > readySoonAlertLength then
        readySoonAlertLength = gcdLength
    end

    return readySoonAlertLength
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