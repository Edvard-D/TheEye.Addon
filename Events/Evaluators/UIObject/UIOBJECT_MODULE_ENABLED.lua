local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_MODULE_ENABLED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_MODULE_ENABLED

local select = select
local table = table


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.type = "STATE"
this.reevaluateEvents =
{
    ADDON_LOADED = true
}
this.gameEvents =
{
    "ADDON_LOADED"
}
this.customEvents =
{
    "SETTING_CHANGED"
}


function this:CalculateCurrentState(inputValues)
    if TheEyeAddon.Settings ~= nil
            and table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, inputValues[1]) == false then
        return true
    else
        return false
    end
end

function this:GetKey(event, ...)
    return select(1, ...) -- SETTING_CHANGED: moduleKey
end

function this:Evaluate(valueGroup, event, ...)
    return this:CalculateCurrentState(valueGroup.inputValues)
end