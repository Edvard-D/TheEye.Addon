TheEye.Core.Helpers.Unit = {}
local this = TheEye.Core.Helpers.Unit

local math = math
local UnitClassification = UnitClassification
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel


function this.IsUnitBoss(unit)
    local unitGUID = UnitGUID(unit)
    local bossMinLevel = math.huge

    for i = 1, 5 do
        local bossUnitID = "boss" .. i
        local bossLevel = UnitLevel(bossUnitID) or math.huge
        bossMinLevel = math.min(bossLevel, bossMinLevel)

        if unitGUID == UnitGUID(bossUnitID) and (bossLevel == -1 or bossMinLevel ~= -1) then
            return true
        end
    end

    local unitClassification = UnitClassification(unit)
    if unitClassification == "worldboss" or (unitClassification == "elite" and UnitLevel(unit) == -1) then
        return true
    end

    return false
end