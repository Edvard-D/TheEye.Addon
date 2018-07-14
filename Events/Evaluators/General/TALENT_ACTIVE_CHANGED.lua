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
    PLAYER_TALENT_UPDATE = true
}
this.gameEvents = 
{
    "PLAYER_TALENT_UPDATE"
}


function this:CalculateCurrentState(inputValues)
    local isKnown = select(11, GetTalentInfo(inputValues[1], inputValues[2], GetActiveSpecGroup()))
    return isKnown
end

function this:Evaluate(inputGroup)
    local isKnown = self:CalculateCurrentState(inputGroup.inputValues)

    if self.currentValue ~= isKnown then
        self.currentValue = isKnown
        return true, this.name, isKnown
    end
end