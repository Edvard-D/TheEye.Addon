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
        local values = {}

        local COOLDOWN = GetPropertiesOfType(icon, "COOLDOWN")
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")


        -- PLAYER_SPELL_COOLDOWN_DURATION_CHANGED
        if COOLDOWN ~= nil then
            value = value * 2
            values.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED = value
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


        -- ValidKeys
        validKeys[baseModifierKeyValue] = true
    end
end