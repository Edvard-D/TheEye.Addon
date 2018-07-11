local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPEC_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPEC_CHANGED
this.name = "UNIT_SPEC_CHANGED"

local GetSpecializationInfo = GetSpecializationInfo
local select = select


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spec ID# #SPEC#ID#
    }
}
]]


reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "ACTIVE_TALENT_GROUP_CHANGED",
    "PLAYER_TARGET_CHANGED"
}


function this:CalculateCurrentState(inputValues)
    local specID

    if inputValues[1] == "player" then
        this.playerSpec = this.playerSpec or select(1, GetSpecializationInfo(GetSpecialization()))
        specID = this.playerSpec
    else
        specID = GetInspectSpecialization(inputValues[1])
    end

    return inputValues[2] == specID
end

function this:GetKey(event, ...) -- doesn't get called on PLAYER_TARGET_CHANGED
    return table.concat({ "player", this.playerSpec })
end

function this:Evaluate(valueGroup, event)
    local isSpec = this:CalculateCurrentState(valueGroup.inputValues)

    if valueGroup.currentState == isSpec then
        valueGroup.currentState = isSpec
        return true, this.name, isSpec
    end
end