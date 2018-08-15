TheEyeAddon.Events.Evaluators.UNIT_IN_COMBAT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_IN_COMBAT_CHANGED
this.name = "UNIT_IN_COMBAT_CHANGED"

local UnitThreatSituation = UnitThreatSituation


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
    "UNIT_THREAT_SITUATION_UPDATE",
}


local function CalculateCurrentValue(inputValues)
    return UnitThreatSituation(inputValues[1]) ~= nil
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit) -- Only called on UNIT_THREAT_SITUATION_UPDATE
    return unit
end

function this:Evaluate(inputGroup, event)
    local inCombat = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= inCombat then
        inputGroup.currentValue = inCombat
        return true, this.name, inCombat
    end
end