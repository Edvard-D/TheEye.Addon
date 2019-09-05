TheEyeAddon.UI.Components.RotationGroup = {}
local this = TheEyeAddon.UI.Components.RotationGroup
local inherited = TheEyeAddon.UI.Components.PriorityGroup

local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local IconsGetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local IconKeyGet = TheEyeAddon.UI.Components.IconGroup.IconKeyGet
local IsIconValidForFilter = TheEyeAddon.Managers.Icons.IsIconValidForFilter
local table = table


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
        
        this.VisibleStateSetup(instance, icon)
        this.ContextIconSetup(instance, icon)
    end
end

function this.VisibleStateSetup(instance, icon)
    local iconUIObject = icon.UIObject
    local validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
    local value = 1
    local values = {}
    local castingKeyValues = {}
    local castStartAlertKeyValues = {}
    local substitutedKeyValues =
    {
        componentVisible = {},
        requirement = {},
        spellcastActive = {},
        final = { 0, }, -- 0 value prevents nil table error in VALID KEYS section 
    }
    local exceptionKeyValues = {}
    local baseModifierKeyValue = 0

    local AURA_APPLIED = GetPropertiesOfType(icon, "AURA_APPLIED")
    local AURA_REPLACED, auraReplacedCount = GetPropertiesOfType(icon, "AURA_REPLACED")
    local AURA_REQUIRED = GetPropertiesOfType(icon, "AURA_REQUIRED")
    local CAST_TYPE = GetPropertiesOfType(icon, "CAST_TYPE")
    local isCastTypeCast = IsIconValidForFilter(icon, { type = "CAST_TYPE", value = "CAST" })
    local isCastTypeChannel = IsIconValidForFilter(icon, { type = "CAST_TYPE", value = "CHANNEL" })
    local isCastTypeInstant = IsIconValidForFilter(icon, { type = "CAST_TYPE", value = "INSTANT" })
    local CATEGORY = GetPropertiesOfType(icon, "CATEGORY")
    local CHARGES = GetPropertiesOfType(icon, "CHARGES")
    local COOLDOWN = GetPropertiesOfType(icon, "COOLDOWN")
    local HEALTH_REQUIRED = GetPropertiesOfType(icon, "HEALTH_REQUIRED")
    local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")
    local OBJECT_TYPE = GetPropertiesOfType(icon, "OBJECT_TYPE")
    local POWER_REQUIRED = GetPropertiesOfType(icon, "POWER_REQUIRED")
    local PVP_REQUIRED = GetPropertiesOfType(icon, "PVP_REQUIRED")
    local UNITS_NEAR_MAX = GetPropertiesOfType(icon, "UNITS_NEAR_MAX")
    local UNITS_NEAR_MIN = GetPropertiesOfType(icon, "UNITS_NEAR_MIN")


    -- CASTING
    -- CastStartAlert
    iconUIObject.CastStartAlert = { spellID = OBJECT_ID.value, }
    value = value * 2
    values.CastStartAlert = value
    table.insert(castingKeyValues, value)
    table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

    table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
        {
            eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
            inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "CastStartAlert" },
            value = value,
        }
    )

    -- CastSoonAlert
    if COOLDOWN ~= nil or CATEGORY.subvalue == "PERIODIC" then
        iconUIObject.CastSoonAlert = { spellID = OBJECT_ID.value, }
        value = value * 2
        values.CastSoonAlert = value
        table.insert(castingKeyValues, value)
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "CastSoonAlert" },
                value = value,
            }
        )
    end

    -- PLAYER_SPELL_COOLDOWN_DURATION_CHANGED
    if COOLDOWN ~= nil and CHARGES == nil then
        value = value * 2
        values.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED = value
        table.insert(castingKeyValues, value)
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        table.insert(castingKeyValues, value + values.CastSoonAlert)
        table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

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

    -- PLAYER_SPELL_CHARGE_CHANGED
    if CHARGES ~= nil then
        iconUIObject["Charges"] = { spellID = OBJECT_ID.value, }
        
        for i = 1, CHARGES.value do
            value = value * 2
            values[table.concat({ "CHARGES", i })] = value
            table.insert(castingKeyValues, value)
            table.insert(castingKeyValues, value + values.CastStartAlert)
            table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
            table.insert(castingKeyValues, value + values.CastSoonAlert)
            table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert)
            table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] OBJECT_ID.value, },
                    comparisonValues =
                    {
                        value = i,
                        type = "EqualTo",
                    },
                    value = value,
                }
            )
        end
    end

    -- CHANNEL
    if isCastTypeChannel == true and COOLDOWN == nil then
        table.insert(castingKeyValues, 0)
    end

    -- UNIT_SPELLCAST_ACTIVE_CHANGED
    if isCastTypeCast == true or isCastTypeChannel == true then
        value = value * 2
        values.UNIT_SPELLCAST_ACTIVE_CHANGED = value

        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        if iconUIObject.CastSoonAlert ~= nil then
            table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert)
            table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
            if COOLDOWN ~= nil and CHARGES == nil then
                table.insert(castingKeyValues, value + values.CastStartAlert + values.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED)
                table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
                table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert + values.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED)
                table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
            end
        end
        if CHARGES ~= nil then
            for i = 1, CHARGES.value do
                local chargeKeyValue = values[table.concat({ "CHARGES", i })]
                table.insert(castingKeyValues, value + chargeKeyValue)
                table.insert(castingKeyValues, value + values.CastStartAlert + chargeKeyValue)
                table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
                table.insert(castingKeyValues, value + values.CastSoonAlert + chargeKeyValue)
                table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert + chargeKeyValue)
                table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
            end
        end

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                inputValues = { --[[unit]] "player", --[[spellID]] OBJECT_ID.value, },
                value = value,
            }
        )
    end

    -- POWER_REQUIRED
    if POWER_REQUIRED ~= nil then
        value = value * 2
        values.PLAYER_SPELL_USEABLE_CHANGED = value
        table.insert(castingKeyValues, value)
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        table.insert(castingKeyValues, value + values.CastStartAlert + values.UNIT_SPELLCAST_ACTIVE_CHANGED)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "PLAYER_SPELL_USEABLE_CHANGED",
                inputValues = { --[[spellID]] OBJECT_ID.value },
                value = value,
            }
        )
    end

    -- PERIODIC
    -- UNIT_AURA_DURATION_CHANGED (PERIODIC)
    if CATEGORY.subvalue == "PERIODIC" then
        value = value * 2
        values.UNIT_AURA_DURATION_CHANGED = value
        table.insert(castingKeyValues, value)
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        table.insert(castingKeyValues, value + values.CastSoonAlert)
        table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        if isCastTypeCast == true or isCastTypeChannel == true then
            table.insert(castingKeyValues, value + values.CastStartAlert + values.UNIT_SPELLCAST_ACTIVE_CHANGED)
            table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
            table.insert(castingKeyValues, value + values.CastStartAlert + values.CastSoonAlert + values.UNIT_SPELLCAST_ACTIVE_CHANGED)
            table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])
        end

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] OBJECT_ID.value, },
                comparisonValues =
                {
                    value = 0,
                    type = "EqualTo"
                },
                value = value,
            }
        )
    end

    -- Substitute Icons (PERIODIC)
    if CATEGORY.subvalue == "PERIODIC" then
        local substituteIcons = IconsGetFiltered(
            {
                {
                    {
                        type = "AURA_APPLIED",
                        value = OBJECT_ID.value,
                    },
                },
            })

        if #substituteIcons > 0 then
            -- Setup
            if #substituteIcons == 1 then
                value = this.SubstitutedSetup(value, OBJECT_ID.value, substituteIcons[1], substitutedKeyValues, instance.UIObject, iconUIObject)
            else
                for i = 1, #substituteIcons do
                    value = this.SubstitutedSetup(value, OBJECT_ID.value, substituteIcons[i], substitutedKeyValues, instance.UIObject, iconUIObject)
                end
            end

            -- Final key values
            local componentVisibleKeys = substitutedKeyValues.componentVisible
            local requirementKeys = substitutedKeyValues.requirement
            local spellcastActiveKeys = substitutedKeyValues.spellcastActive
            local finalKeys = substitutedKeyValues.final

            for i = 1, #componentVisibleKeys do
                if requirementKeys[i] ~= 0 then
                    table.insert(substitutedKeyValues.final, componentVisibleKeys[i])
                end
            end

            for i = 1, #requirementKeys do
                table.insert(substitutedKeyValues.final, requirementKeys[i])
                if requirementKeys[i] ~= 0 then
                    table.insert(exceptionKeyValues, requirementKeys[i] + spellcastActiveKeys[i] + values.UNIT_AURA_DURATION_CHANGED)
                end
            end

            for i = 1, #spellcastActiveKeys do
                table.insert(substitutedKeyValues.final, spellcastActiveKeys[i])
            end

            for i = 1, #componentVisibleKeys do
                table.insert(castingKeyValues, values.CastStartAlert + componentVisibleKeys[i])
                table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

                for j = 1, #requirementKeys do
                    if i ~= j then
                        table.insert(finalKeys, componentVisibleKeys[i] + requirementKeys[j])
                    end
                end
            end
        end
    end


    -- SELF BUFF
    if CATEGORY.value == "BUFF" and CATEGORY.subvalue == "POWER" and CAST_TYPE ~= nil then
        value = value * 2
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

        if COOLDOWN == nil then
            table.insert(castingKeyValues, 0)
        end

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] OBJECT_ID.value },
                value = value,
            }
        )

        if AURA_REPLACED ~= nil then
            if auraReplacedCount == 1 then
                value = this.AuraReplacedSetup(value, AURA_REPLACED, iconUIObject)
            else
                for i = 1, #AURA_REPLACED do
                    value = this.AuraReplacedSetup(value, AURA_REPLACED[i], iconUIObject)
                end
            end
        end
    end

    -- AURA_APPLIED different than OBJECT_ID
    if AURA_APPLIED ~= nil and AURA_APPLIED.value ~= OBJECT_ID.value and isCastTypeChannel == false then
        value = value * 2

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] AURA_APPLIED.value },
                value = value,
            }
        )
    end

    -- BASE MODIFIER
    if HEALTH_REQUIRED ~= nil then
        -- UNIT_HEALTH_PERCENT_CHANGED
        value = value * 2
        values.UNIT_HEALTH_PERCENT_CHANGED = value
        baseModifierKeyValue = baseModifierKeyValue + value

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                inputValues = { --[[unit]] "target", },
                comparisonValues =
                {
                    value = HEALTH_REQUIRED.value,
                    type = HEALTH_REQUIRED.comparison,
                },
                value = value,
            }
        )

        -- UNIT_CAN_ATTACK_UNIT_CHANGED
        value = value * 2
        baseModifierKeyValue = baseModifierKeyValue + value

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
                inputValues = { --[[unti1]] "player", --[[unit2]] "target", },
                value = value,
            }
        )
    end

    if AURA_REQUIRED ~= nil then
        if AURA_REQUIRED.stacks == nil then
            -- UNIT_AURA_ACTIVE_CHANGED
            value = value * 2
            values.UNIT_AURA_ACTIVE_CHANGED = value
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] AURA_REQUIRED.value, },
                    value = value,
                }
            )
        else
            -- UNIT_AURA_STACK_CHANGED
            value = value * 2
            values.UNIT_AURA_STACK_CHANGED = value
            baseModifierKeyValue = baseModifierKeyValue + value

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_AURA_STACK_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] AURA_REQUIRED.value, },
                    comparisonValues =
                    {
                        value = AURA_REQUIRED.stacks,
                        type = AURA_REQUIRED.comparison,
                    },
                value = value,
                }
            )
        end
    end

    -- UNIT_COUNT_CLOSE_TO_UNIT_CHANGED
    if UNITS_NEAR_MAX ~= nil or UNITS_NEAR_MIN ~= nil then
        value = value * 2
        values.UNIT_COUNT_CLOSE_TO_UNIT_CHANGED = value
        baseModifierKeyValue = baseModifierKeyValue + value

        local ceiling = math.huge
        if UNITS_NEAR_MAX ~= nil then
            ceiling = UNITS_NEAR_MAX.value
        end

        local floor = 0
        if UNITS_NEAR_MIN ~= nil then
            floor = UNITS_NEAR_MIN.value
        end
        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                comparisonValues =
                {
                    ceiling = ceiling,
                    floor = floor,
                    type = "Between"
                },
                value = value,
            }
        )
    end

    -- UNIT_PVP_FLAGGED_CHANGED
    if PVP_REQUIRED ~= nil then -- @TODO refactor to check if spell is useable so it works at target dummies
        value = value * 2
        values.UNIT_PVP_FLAGGED_CHANGED = value
        baseModifierKeyValue = baseModifierKeyValue + value

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_PVP_FLAGGED_CHANGED",
                inputValues = { --[[unit]] "player" },
                value = value,
            }
        )
    end


    -- VALID KEYS
    for i = 1, #castStartAlertKeyValues do
        validKeys[castStartAlertKeyValues[i]] = true
    end

    local finalSubstitutedKeyValues = substitutedKeyValues.final
    for i = 1, #castingKeyValues do
        for j = 1, #finalSubstitutedKeyValues do
            validKeys[castingKeyValues[i] + finalSubstitutedKeyValues[j] + baseModifierKeyValue] = true
        end
    end

    -- Remove key values that are known to be invalid
    for i = 1, #exceptionKeyValues do
        validKeys[exceptionKeyValues[i]] = nil
    end
end

function this.SubstitutedSetup(value, spellID, substituteIcon, substitutedKeyValues, instanceUIObject, iconUIObject) 
    local OBJECT_ID = GetPropertiesOfType(substituteIcon, "OBJECT_ID")

    if OBJECT_ID.value ~= spellID then
        local AURA_APPLIED = GetPropertiesOfType(substituteIcon, "AURA_APPLIED", spellID)
        local baseValue
        local isCastTypeCast = IsIconValidForFilter(substituteIcon, { type = "CAST_TYPE", value = "CAST" })
        local isCastTypeChannel = IsIconValidForFilter(substituteIcon, { type = "CAST_TYPE", value = "CHANNEL" })


        value = value * 2
        baseValue = value
        table.insert(substitutedKeyValues.componentVisible, value)

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                inputValues = { --[[uiObject]] IconKeyGet("SPELL", OBJECT_ID.value, instanceUIObject), --[[componentName]] "VisibleState" },
                value = value,
            }
        )


        if AURA_APPLIED.requirement ~= nil then
            value = value * 2
            table.insert(substitutedKeyValues.requirement, value)

            if AURA_APPLIED.requirement.type == "TALENT_REQUIRED" then
                table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners, 
                    {
                        eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                        inputValues = { --[[talentID]] AURA_APPLIED.requirement.value, },
                        value = value,
                    }
                )
            end
        else
            table.insert(substitutedKeyValues.requirement, 0)
        end


        if isCastTypeCast == true or isCastTypeChannel == true then
            value = value * 2
            table.insert(substitutedKeyValues.spellcastActive, value)

            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] OBJECT_ID.value, },
                    value = value,
                }
            )
        else
            table.insert(substitutedKeyValues.spellcastActive, 0)
        end
    end
    
    return value
end

function this.AuraReplacedSetup(value, AURA_REPLACED, iconUIObject)
    value = value * 2

    table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
        {
            eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
            inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] AURA_REPLACED.value },
            value = value,
        }
    )
    
    return value
end

function this.ContextIconSetup(instance, icon)
    local listeners = {}
    local validKeys = {}

    local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")
    local appliedAuras, appliedAurasCount = GetPropertiesOfType(icon, "AURA_APPLIED", nil, true)
    local CAST_TYPE, castTypeCount = GetPropertiesOfType(icon, "CAST_TYPE")
    local UNITS_NEAR_MIN = GetPropertiesOfType(icon, "UNITS_NEAR_MIN")
    
    local instantCastProperty
    if castTypeCount > 1 then
        for i = 1, castTypeCount do
            if CAST_TYPE[i].value == "INSTANT" and CAST_TYPE[i].requirement ~= nil then
                instantCastProperty = CAST_TYPE[i]
            end
        end
    end


    -- Substitutes Icons
    if appliedAurasCount > 0 then
        local AURA_APPLIED
        local value = 1
        local values = {}

        if appliedAurasCount == 1 then
            AURA_APPLIED = appliedAuras
        else
            for i = 1, appliedAurasCount do
                local property = appliedAuras[i]
                
                if property.value ~= OBJECT_ID.value then
                    AURA_APPLIED = property
                end
            end
        end
        
        local substituteIcons = IconsGetFiltered(
            {
                {
                    {
                        type = "OBJECT_ID",
                        value = AURA_APPLIED.value,
                    },
                    {
                        type = "CATEGORY",
                        value = "DAMAGE",
                        subvalue = "PERIODIC",
                    },
                },
            })
        
        if #substituteIcons == 1 and AURA_APPLIED.value ~= OBJECT_ID.value then
            -- UIOBJECT_COMPONENT_STATE_CHANGED
            value = value * 2
            values.UIOBJECT_COMPONENT_STATE_CHANGED = value

            table.insert(listeners,
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] IconKeyGet("SPELL", AURA_APPLIED.value, instance.UIObject), --[[componentName]] "CastSoonAlert", },
                    value = value,
                }
            )

            -- UNIT_AURA_DURATION_CHANGED
            value = value * 2
            values.UNIT_AURA_DURATION_CHANGED = value

            table.insert(listeners,
                {
                    eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] AURA_APPLIED.value, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = value,
                }
            )

            -- REQUIREMENTS
            values.requirement = 0
            if AURA_APPLIED.requirement ~= nil then
                value = value * 2
                values.requirement = value
        
                if AURA_APPLIED.requirement.type == "TALENT_REQUIRED" then
                    table.insert(listeners, 
                        {
                            eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                            inputValues = { --[[talentID]] AURA_APPLIED.requirement.value, },
                            value = value,
                        }
                    )
                end
            end
        

            -- Valid Keys
            validKeys[values.UIOBJECT_COMPONENT_STATE_CHANGED + values.requirement] = true
            validKeys[values.UNIT_AURA_DURATION_CHANGED + values.requirement] = true
            validKeys[values.UIOBJECT_COMPONENT_STATE_CHANGED + values.UNIT_AURA_DURATION_CHANGED + values.requirement] = true
        
            
            icon.UIObject.ContextIcon =
            {
                iconObjectType = "SPELL",
                iconObjectID = AURA_APPLIED.value,
                ValueHandler = { validKeys = validKeys, },
                ListenerGroup = { Listeners = listeners, },
            }
        end
    end
    
    if UNITS_NEAR_MIN ~= nil then
        icon.UIObject.ContextIcon =
        {
            iconObjectType = "SPELL",
            iconObjectID = 277702, -- crosshair symbol
            ValueHandler =
            {
                validKeys = { [0] = true, },
            },
            TextValueListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                        inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                    },
                },
            },
        }
    end

    if instantCastProperty ~= nil then
        icon.UIObject.ContextIcon =
        {
            iconObjectType = "SPELL",
            iconObjectID = instantCastProperty.requirement.value,
            ValueHandler =
            {
                validKeys = { [2] = true, },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                        inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] instantCastProperty.requirement.value },
                        value = 2,
                    },
                },
            },
        }
    end
end