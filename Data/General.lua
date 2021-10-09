local this = TheEye.Core.Data


this.screenSize =
{
    width = GetScreenWidth(),
    height = GetScreenHeight(),
}
this.powerIDs =
{
    MANA = 0,
    RAGE = 1,
    FOCUS = 2,
    ENERGY = 3,
    COMBO_POINTS = 4,
    RUNES = 5,
    RUNIC_POWER = 6,
    SOUL_SHARDS = 7,
    LUNAR_POWER = 8,
    HOLY_POWER = 9,
    ALTERNATE = 10,
    MAELSTROM = 11,
    CHI = 12,
    INSANITY = 13,
    ARCANE_CHARGES = 16,
    FURY = 17,
    PAIN = 18,
}
this.raidMarkerFileIDs =
{
    [1] = 137001,
    [2] = 137002,
    [3] = 137003,
    [4] = 137004,
    [5] = 137005,
    [6] = 137006,
    [7] = 137007,
    [8] = 137008,
}
this.powerLowThreshold = 0.5
this.frameMinSize = 0.0001