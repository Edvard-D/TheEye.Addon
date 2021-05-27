TheEye.Core.Evaluators.UNIT_FACTION_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_FACTION_CHANGED

local UnitFactionGroup = UnitFactionGroup


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    
    return select(1, UnitFactionGroup(unit))
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local faction = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= faction then
        inputGroup.currentValue = faction
        return true, this.key
    end
end