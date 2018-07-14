-- Allowed filters: HELPFUL, HARMFUL, CANCELABLE, NOT_CANCELABLE
-- All filters must have a space after them

local TheEyeAddon = TheEyeAddon
TheEyeAddon.Auras.Filters = {}


TheEyeAddon.Auras.Filters.SpellID =
{
    [589] = -- Shadow Word: Pain
    {
        "HARMFUL "
    },
    [34914] = -- Vampiric Touch
    {
        "HARMFUL "
    }
}