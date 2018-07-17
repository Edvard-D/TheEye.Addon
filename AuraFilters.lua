-- Allowed filters: HELPFUL, HARMFUL, CANCELABLE, NOT_CANCELABLE
-- All filters must have a space after them

local TheEyeAddon = TheEyeAddon
TheEyeAddon.Auras.Filters = {}


TheEyeAddon.Auras.Filters.SpellID =
{
    [589] = -- Shadow Word: Pain
    {
        "HARMFUL ", "NOT_CANCELABLE "
    },
    [34914] = -- Vampiric Touch
    {
        "HARMFUL ", "NOT_CANCELABLE "
    },
    [194249] = -- Voidform
    {
        "HELPFUL ", "NOT_CANCELABLE "
    }
}