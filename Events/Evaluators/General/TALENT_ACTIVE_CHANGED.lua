local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.TALENT_ACTIVE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.TALENT_ACTIVE_CHANGED
this.name = "TALENT_ACTIVE_CHANGED"

local GetActiveSpecGroup = GetActiveSpecGroup
local GetTalentInfo = GetTalentInfo
local select = select


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Tier# #INT#,
        #LABEL#Column# #INT#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TALENT_UPDATE = true,
    UNIT_INVENTORY_CHANGED = true,
}
this.gameEvents = 
{
    "PLAYER_TALENT_UPDATE",
    "UNIT_INVENTORY_CHANGED",
}


function this:CalculateCurrentValue(inputValues)
    local isSelected, _, _, _, _, _, _, isKnown = select(4, GetTalentInfo(inputValues[1], inputValues[2], GetActiveSpecGroup()))
    return isSelected or isKnown
end

function this:Evaluate(inputGroup)
    local isKnown = self:CalculateCurrentValue(inputGroup.inputValues)

    print("isKnown: " .. tostring(isKnown))
    if self.currentValue ~= isKnown then
        self.currentValue = isKnown
        return true, this.name, isKnown
    end
end