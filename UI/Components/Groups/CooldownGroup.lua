TheEyeAddon.UI.Components.CooldownGroup = {}
local this = TheEyeAddon.UI.Components.CooldownGroup
local inherited = TheEyeAddon.UI.Components.IconGroup

local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType


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

        local CATEGORY = GetPropertiesOfType(icon, "CATEGORY")
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")


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

            if priorityDisplayers[i] == "ROTATION" and CATEGORY.value == "DAMAGE" then
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