TheEye.Core.Evaluators.UNIT_AFFECTING_COMBAT_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_AFFECTING_COMBAT_CHANGED

local UnitAffectingCombat = UnitAffectingCombat


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
    "PLAYER_REGEN_ENABLED",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_TARGET_CHANGED",
    "UNIT_COMBAT",
}


local function CalculateCurrentValue(inputValues)
    return UnitAffectingCombat(inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, ...)
    local unit
    if event == "UNIT_COMBAT" then
        unit = select(1, ...)
    elseif event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
        unit = "player"
    end
    
    return unit
end

function this:Evaluate(inputGroup, event)
    local inCombat = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= inCombat then
        inputGroup.currentValue = inCombat
        return true, this.key
    end
end