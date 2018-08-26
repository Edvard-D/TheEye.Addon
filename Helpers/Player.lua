TheEyeAddon.Helpers.Player = {}
local this = TheEyeAddon.Helpers.Player

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local select = select


function this.SpellChargeCooldownRemainingTimeGet(inputValues)
    local start, duration = select(3, GetSpellCharges(inputValues[1]))
    local remainingTime = (start + duration) - GetTime()

    if remainingTime < 0 or remainingTime > 600 then
        remainingTime = 0
    end
    return remainingTime
end