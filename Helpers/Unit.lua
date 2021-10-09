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

function this.UnitCategoryGet(unit)
    if unit == nil then
        return "NONE"
    elseif unit == "player" then
        return "PLAYER"
    elseif string.find(unit, "raidpet") ~= nil or string.find(unit, "partypet") then
        return "FRIENDLY_PET"
    elseif string.find(unit, "raid") ~= nil or string.find(unit, "party") then
        return "FRIENDLY"
    elseif string.find(unit, "boss") ~= nil then
        return "BOSS"
    else
        return "OTHER"
    end
end