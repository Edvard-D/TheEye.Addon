TheEyeAddon.Evaluators.UNIT_RAID_MARKER_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_RAID_MARKER_CHANGED

local UnitName = UnitName


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_REGEN_DISABLED = true,
    PLAYER_TARGET_CHANGED = true,
}
this.gameEvents =
{
    "PLAYER_REGEN_DISABLED",
    "PLAYER_TARGET_CHANGED",
}

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = GetRaidTargetIndex(inputGroup.inputValues[1])
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local raidTargetIndex = GetRaidTargetIndex(inputGroup.inputValues[1])

    if inputGroup.currentValue ~= raidTargetIndex then
        inputGroup.currentValue = raidTargetIndex
        return true, this.key
    end
end