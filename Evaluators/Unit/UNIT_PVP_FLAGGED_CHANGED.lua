TheEyeAddon.Evaluators.UNIT_PVP_FLAGGED_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_PVP_FLAGGED_CHANGED

local IsWarModeActive = C_PvP.IsWarModeActive
local UnitIsPVP = UnitIsPVP


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT#, }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
}
this.gameEvents = 
{
    "PLAYER_TARGET_CHANGED",
    "PLAYER_FLAGS_CHANGED",
}

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = UnitIsPVP(inputGroup.inputValues[1])
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local pvpEnabled = UnitIsPVP(inputGroup.inputValues[1])
    if inputGroup.currentValue ~= pvpEnabled then
        inputGroup.currentValue = pvpEnabled
        return true, this.key
    end
end