local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.PLAYER_TALENT_KNOWN_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_TALENT_KNOWN_CHANGED
this.name = "PLAYER_TALENT_KNOWN_CHANGED"

local GetAllSelectedPvpTalentIDs = C_SpecializationInfo.GetAllSelectedPvpTalentIDs
local GetTalentInfoByID = GetTalentInfoByID
local select = select


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Talent ID# #INT#,
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


local function CalculateCurrentValue(inputValues)
    local talentID = inputValues[1]

    local isKnown = select(10, GetTalentInfoByID(talentID, 1))
    if isKnown == true then
        return true
    end

    local pvpTalents = GetAllSelectedPvpTalentIDs()
    for i = 1, #pvpTalents do
        if pvpTalents[i] == talentID then
            return true
        end
    end

    return false
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup)
    local isKnown = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isKnown then
        inputGroup.currentValue = isKnown
        return true, this.name, isKnown
    end
end