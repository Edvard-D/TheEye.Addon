TheEyeAddon.UI.Components.ActiveGroup = {}
local this = TheEyeAddon.UI.Components.ActiveGroup
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
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")


        -- BUFF
        if (CATEGORY.value == "DAMAGE" and CATEGORY.subvalue == "BUFF")
            or CATEGORY.value == "DEFENSIVE"
            then
            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] OBJECT_ID.value, },
                    value = value,
                }
            )
        end

        -- MINION
        if CATEGORY.value == "DAMAGE" and CATEGORY.subvalue == "MINION" then
            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIME_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] OBJECT_ID.value, },
                    comparisonValues =
                    {
                        value = CATEGORY.length,
                        type = "LessThan"
                    },
                    value = value,
                }
            )
        end

        -- TOTEM
        if CATEGORY.value == "DAMAGE" and CATEGORY.subvalue == "TOTEM" then
            value = value * 2
            baseModifierKeyValue = baseModifierKeyValue + value

            local spellName = GetSpellInfo(OBJECT_ID.value)
            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "PLAYER_TOTEM_ACTIVE_CHANGED",
                    inputValues = { --[[totemName]] spellName, },
                    value = value,
                }
            )
        end


        -- ValidKeys
        validKeys[baseModifierKeyValue] = true
    end
end