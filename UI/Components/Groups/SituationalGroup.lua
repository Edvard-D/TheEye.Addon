TheEye.Core.UI.Components.SituationalGroup = {}
local this = TheEye.Core.UI.Components.SituationalGroup
local inherited = TheEye.Core.UI.Components.PriorityGroup

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
    for i = 1, #icons do
        local icon = icons[i]
        local moduleSettings = _G["TheEyeCharacterSettings"].UI.Modules["SITUATIONAL"]
        local COOLDOWN = GetPropertiesOfType(icon, "COOLDOWN")
        
        if (COOLDOWN ~= nil and COOLDOWN.value >= 20)
            or moduleSettings.isLongCooldownsOnly == false
            then
            local baseModifierKeyValue = 0
            local iconUIObject = icon.UIObject
            local validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
            local value = 1

            local CATEGORY = GetPropertiesOfType(icon, "CATEGORY")
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

            -- UNIT_AURA_ACTIVE_CHANGED
            if CATEGORY.value == "BUFF" and CATEGORY.subvalue == "SURVIVABILITY" then
                value = value * 2

                table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                    {
                        eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                        inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] OBJECT_ID.value },
                        value = value,
                    }
                )
            end


            -- ValidKeys
            validKeys[baseModifierKeyValue] = true
        end
    end
end