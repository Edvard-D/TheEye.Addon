TheEyeAddon.UI.Components.SituationalGroup = {}
local this = TheEyeAddon.UI.Components.SituationalGroup
local inherited = TheEyeAddon.UI.Components.PriorityGroup

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
    for i = 1, #icons do
        local baseModifierKeyValue = 0
        local icon = icons[i]
        local iconUIObject = icon.UIObject
        local validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
        local value = 1

        local CATEGORY = GetPropertiesOfType(icon, "CATEGORY")
        local COOLDOWN = GetPropertiesOfType(icon, "COOLDOWN")
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")


        -- PLAYER_SPELL_COOLDOWN_DURATION_CHANGED
        if COOLDOWN ~= nil then
            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] OBJECT_ID.value },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo"
                    },
                    value = value,
                }
            )
        end
        
        -- DEFENSIVE (THREAT)
        if CATEGORY.value == "DEFENSIVE" and CATEGORY.subvalue == "THREAT" then
            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_THREAT_SITUATION_CHANGED",
                    inputValues = { --[[unit]] "player", --[[otherUnit]] "_", },
                    comparisonValues =
                    {
                        value = 1,
                        type = "GreaterThanEqualTo"
                    },
                    value = value,
                }
            )

            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_IN_GROUP_CHANGED",
                    inputValues = { --[[unit]] "player", },
                    value = value,
                }
            )
        end


        -- ValidKeys
        validKeys[baseModifierKeyValue] = true
    end
end