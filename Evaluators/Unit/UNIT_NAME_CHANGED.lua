TheEyeAddon.Evaluators.UNIT_NAME_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_NAME_CHANGED

local UnitName = UnitName


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
}

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = UnitName(inputGroup.inputValues[1])
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local unitName = UnitName(inputGroup.inputValues[1])

    if inputGroup.currentValue ~= unitName then
        inputGroup.currentValue = unitName
        return true, this.key
    end
end