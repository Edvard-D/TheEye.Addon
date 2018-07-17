local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPEC_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPEC_CHANGED
this.name = "UNIT_SPEC_CHANGED"

local GetInspectSpecialization = GetInspectSpecialization
local GetSpecialization = GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local select = select
local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spec ID# #SPEC#ID#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "ACTIVE_TALENT_GROUP_CHANGED",
    "PLAYER_TARGET_CHANGED"
}


local function CalculateCurrentValue(inputValues)
    local specID

    if inputValues[1] == "player" then
        this.playerSpec = this.playerSpec or select(1, GetSpecializationInfo(GetSpecialization()))
        specID = this.playerSpec
    else
        specID = GetInspectSpecialization(inputValues[1])
    end

    return inputValues[2] == specID
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, ...) -- doesn't get called on PLAYER_TARGET_CHANGED
    return table.concat({ "player", this.playerSpec })
end

function this:Evaluate(inputGroup, event)
    local isSpec = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isSpec then
        inputGroup.currentValue = isSpec
        return true, this.name, isSpec
    end
end