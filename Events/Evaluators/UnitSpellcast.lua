local TheEyeAddon = TheEyeAddon

local select = select


TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active =
{
    gameEvents = { "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP" },
    Evaluate = function(event)
        local unit = select(1, event)
        local spellID = select(5, event)
        
        if event == "UNIT_SPELLCAST_START" then
            return table.concat({ unit, spellID }), true
        else
            return table.concat({ unit, spellID }), false
        end
    end
}