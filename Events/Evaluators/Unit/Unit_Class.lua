local TheEyeAddon = TheEyeAddon

local select = select
local UnitClass = UnitClass


-- inputValues = { --[[unit]] "_", --[[classIndex]] 0 }
--      unit: required
--      classIndex: required
TheEyeAddon.Events.Evaluators.Unit_Class =
{
    type = "STATE",
    reevaluateEvents =
    {
        PLAYER_TARGET_CHANGED = true
    },
    gameEvents =
    {
        "PLAYER_TARGET_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_Class:CalculateCurrentState(inputValues)
    local classIndex = select(3, UnitClass(inputValues[1]))
    return classIndex == inputValues[2]
end

function TheEyeAddon.Events.Evaluators.Unit_Class:Evaluate(valueGroup)
    return TheEyeAddon.Events.Evaluators.Unit_Class:CalculateCurrentState(valueGroup.inputValues)
end