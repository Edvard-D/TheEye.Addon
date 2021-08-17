TheEye.Core.UI.Components.CooldownGroup = {}
local this = TheEye.Core.UI.Components.CooldownGroup
local inherited = TheEye.Core.UI.Components.IconGroup

local GetPropertiesOfType = TheEye.Core.Managers.Icons.GetPropertiesOfType


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    
    inherited.Setup(
        instance
    )

    local icons = instance.Icons
    local priorityDisplayers = instance.PriorityDisplayers
    for i = 1, #icons do
        local icon = icons[i]
        local iconUIObject = icon.UIObject
        local validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
        local value = 1

        local AURA_APPLIED = GetPropertiesOfType(icon, "AURA_APPLIED")
        local CAST_TYPE = GetPropertiesOfType(icon, "CAST_TYPE")
        local CATEGORY = GetPropertiesOfType(icon, "CATEGORY")
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")
        local USAGE_RATE = GetPropertiesOfType(icon, "USAGE_RATE")


        -- UIOBJECT_COMPONENT_STATE_CHANGED (Cooldown)
        iconUIObject.Cooldown = { spellID = OBJECT_ID.value, }

        value = value * 2
        validKeys[value] = true

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "Cooldown" },
                value = value,
            }
        )

        -- ICON_DISPLAYER_CHANGED
        for i = 1, #priorityDisplayers do
            value = value * 2

            if (priorityDisplayers[i] == "ROTATION"
                    and (CATEGORY.value == "DAMAGE"
                        or (CATEGORY.value == "BUFF" and CATEGORY.subvalue == "POWER")))
                or (priorityDisplayers[i] == "ACTIVE"
                    and ((CATEGORY.value == "DAMAGE" and (CATEGORY.subvalue == "SUMMON" or CATEGORY.subvalue == "TOTEM"))
                        or (CATEGORY.value == "DEFENSIVE" and AURA_APPLIED ~= nil)
                        or (CATEGORY.value == "HEAL" and AURA_APPLIED ~= nil)
                        or (CATEGORY.value == "BUFF" and (CAST_TYPE.value == "CAST" or CAST_TYPE.value == "INSTANT"))))
                then
                table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                    {
                        eventEvaluatorKey = "ICON_DISPLAYER_CHANGED",
                        inputValues = { --[[spellID]] OBJECT_ID.value, --[[displayerID]] priorityDisplayers[i] },
                        value = value,
                    }
                )
            end
        end
    end
end