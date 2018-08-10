-- Allowed filters: HELPFUL, HARMFUL, CANCELABLE, NOT_CANCELABLE
-- All filters must have a space after them

TheEyeAddon.Values.auraFilters =
{
    [589] = -- Shadow Word: Pain
    {
        "HARMFUL "
    },
    [34914] = -- Vampiric Touch
    {
        "HARMFUL "
    },
    [194249] = -- Voidform
    {
        "HELPFUL " -- @TODO figure out why using NOT_CANCELABLE caused this aura to not be found
    }
}