TheEye.Core.Helpers.Spells = {}
local this = TheEye.Core.Helpers.Spells

local FindSpellOverrideByID = FindSpellOverrideByID
local GetSpellBookItemInfo = GetSpellBookItemInfo
local GetSpellTabInfo = GetSpellTabInfo
local IsPassiveSpell = IsPassiveSpell
local table = table


function this.CurrentSpellsGet(mustBeUseable)
    local currentSpells = {}

    for i = 2, 3 do
        _, _, offset, entryCount, _, _ = GetSpellTabInfo(i)

        for j = offset + 1, offset + entryCount do
            spellType, spellID = GetSpellBookItemInfo(j, "spell")
            spellID = FindSpellOverrideByID(spellID)
            
            if IsPassiveSpell(spellID) == false
                    and (spellType == "SPELL" or (mustBeUseable == false and spellType == "FUTURESPELL")) then
                table.insert(currentSpells, spellID)
            end
        end
    end

    return currentSpells
end