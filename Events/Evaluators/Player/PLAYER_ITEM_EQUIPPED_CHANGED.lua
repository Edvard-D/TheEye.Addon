TheEyeAddon.Events.Evaluators.PLAYER_ITEM_EQUIPPED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_ITEM_EQUIPPED_CHANGED
this.name = "PLAYER_ITEM_EQUIPPED_CHANGED"

local IsEquippedItem = IsEquippedItem


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Item ID# #INT#,
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_EQUIPMENT_CHANGED = true,
}
this.gameEvents = 
{
    "PLAYER_EQUIPMENT_CHANGED",
}


local function CalculateCurrentValue(inputValues)
    return IsEquippedItem(inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup)
    local isEquipped = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isEquipped then
        inputGroup.currentValue = isEquipped
        return true, this.name, isEquipped
    end
end