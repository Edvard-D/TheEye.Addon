TheEye.Core.Evaluators.PLAYER_SPELL_CHARGE_CHANGED = {}
local this = TheEye.Core.Evaluators.PLAYER_SPELL_CHARGE_CHANGED

local GetSpellCharges = GetSpellCharges


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT#, }
}
]]


this.reevaluateEvents =
{
    SPELL_UPDATE_CHARGES = true,
}
this.gameEvents =
{
    "SPELL_UPDATE_CHARGES",
}


local function CalculateCurrentValue(inputValues)
    local charges = GetSpellCharges(inputValues[1])
    return charges
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local charges = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= charges then
        inputGroup.currentValue = charges
        return true, this.key
    end
end