TheEyeAddon.Evaluators.UNIT_PVP_FLAGGED_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_PVP_FLAGGED_CHANGED

local IsWarModeActive = C_PvP.IsWarModeActive
local IsWarModeDesired = C_PvP.IsWarModeDesired
local UnitIsPVP = UnitIsPVP
local UnitName = UnitName


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


local function CalculateCurrentValue(inputValues)
    if inputValues[1] == "player" then
        local isActive = IsWarModeActive()

        if UnitName("target") == "Training Dummy" and IsWarModeDesired() == true then
            isActive = true
        end

        return isActive
    else
        return UnitIsPVP(inputValues[1])
    end
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local isPvPActive = CalculateCurrentValue(inputGroup.inputValues)
    if inputGroup.currentValue ~= isPvPActive then
        inputGroup.currentValue = isPvPActive
        return true, this.key
    end
end