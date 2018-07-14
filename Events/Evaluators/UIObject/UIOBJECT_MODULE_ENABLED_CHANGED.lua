local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_MODULE_ENABLED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_MODULE_ENABLED_CHANGED
this.name = "UIOBJECT_MODULE_ENABLED_CHANGED"

local select = select
local table = table


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


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


function this:CalculateCurrentValue(inputValues)
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

function this:Evaluate(inputGroup, event, ...)
    local isEnabled = this:CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isEnabled then
        inputGroup.currentValue = isEnabled
        return true, this.name, isEnabled
    end
end