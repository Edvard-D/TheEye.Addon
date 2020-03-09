TheEye.Core.Evaluators.UNIT_IN_GROUP_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_IN_GROUP_CHANGED

local GetNumGroupMembers = GetNumGroupMembers
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
    RAID_ROSTER_UPDATE = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "RAID_ROSTER_UPDATE",
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    local inGroup = false
    
    if unit == "player" then
        inGroup = GetNumGroupMembers() > 0
    else
        inGroup = UnitInParty(unit) or 0 + UnitInRaid(unit) or 0 > 0
    end
    
    return inGroup
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local inGroup = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= inGroup then
        inputGroup.currentValue = inGroup
        return true, this.key
    end
end