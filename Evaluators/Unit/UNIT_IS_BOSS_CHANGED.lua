TheEye.Core.Evaluators.UNIT_IS_BOSS_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_IS_BOSS_CHANGED

local IsUnitBoss = TheEye.Core.Helpers.Unit.IsUnitBoss

--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_REGEN_DISABLED = true,
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_REGEN_DISABLED",
    "PLAYER_TARGET_CHANGED",
}

local function CalculateCurrentValue(inputValues)
    return IsUnitBoss(inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local isBoss = CalculateCurrentValue(inputGroup.inputValues)
    
    if inputGroup.currentValue ~= isBoss then
        inputGroup.currentValue = isBoss
        return true, this.key
    end
end