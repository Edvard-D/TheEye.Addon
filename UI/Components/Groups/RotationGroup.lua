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
    local baseModifierKeyValue = 0

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
    local SUBSTITUTED, substitutedCount = GetPropertiesOfType(icon, "SUBSTITUTED")
    local TARGETING = GetPropertiesOfType(icon, "TARGETING")
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
    if COOLDOWN ~= nil or CATEGORY.subvalue == "DOT" then
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

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "PLAYER_SPELL_USEABLE_CHANGED",
                inputValues = { --[[spellID]] OBJECT_ID.value },
                value = value,
            }
        )
    end

    -- DOT
    -- UNIT_AURA_DURATION_CHANGED (DOT)
    if CATEGORY.subvalue == "DOT" then
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

    -- SUBSTITUTED (DOT)
    if SUBSTITUTED ~= nil and CATEGORY.subvalue == "DOT" then
        -- Setup
        if substitutedCount == 1 then
            value = this.SubstitutedSetup(value, SUBSTITUTED, 1, substitutedKeyValues, instance.UIObject, iconUIObject)
        else
            for i = 1, substitutedCount do
                value = this.SubstitutedSetup(value, SUBSTITUTED[i], i, substitutedKeyValues, instance.UIObject, iconUIObject)
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


    -- SELF BUFF
    if CATEGORY.subvalue == "BUFF" and TARGETING.value == "SELF" then
        value = value * 2
        table.insert(castingKeyValues, 0)
        table.insert(castingKeyValues, value + values.CastStartAlert)
        table.insert(castStartAlertKeyValues, castingKeyValues[#castingKeyValues])

        table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
            {
                eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] OBJECT_ID.value },
                value = value,
            }
        )

        if SUBSTITUTED ~= nil then
            if substitutedCount == 1 then
                value = this.SelfBuffSubstitutedSetup(value, SUBSTITUTED, iconUIObject)
            else
                for i = 1, #substitutedCount do
                    value = this.SelfBuffSubstitutedSetup(value, SUBSTITUTED[i], iconUIObject)
                end
            end
        end
    end


    -- BASE MODIFIER
    -- UNIT_HEALTH_PERCENT_CHANGED
    if HEALTH_REQUIRED ~= nil then
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
    if PVP_REQUIRED ~= nil then
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

    -- @TODO ContextIcon
    -- @TODO Aura inactive (SW:D)
    -- @TODO Power %
    -- @TODO Another ability applies this one and isn't visible (Shadow Word: Pain with Misery talented)
end

function this.SubstitutedSetup(value, SUBSTITUTED, currentSubstitutedCount, substitutedKeyValues, instanceUIObject, iconUIObject)
    local baseValue
    local substituteIcon = IconsGetFiltered(
        {
            {
                type = "OBJECT_ID",
                value = SUBSTITUTED.value,
            },
        }
    )[1]
    local isCastTypeCast = IsIconValidForFilter(substituteIcon, { type = "CAST_TYPE", value = "CAST" })
    local isCastTypeChannel = IsIconValidForFilter(substituteIcon, { type = "CAST_TYPE", value = "CHANNEL" })


    value = value * 2
    baseValue = value
    table.insert(substitutedKeyValues.componentVisible, value)

    table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
        {
            eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
            inputValues = { --[[uiObject]] IconKeyGet("SPELL", SUBSTITUTED.value, instanceUIObject), --[[componentName]] "VisibleState" },
            value = value,
        }
    )


    if SUBSTITUTED.requirement ~= nil then
        value = value * 2
        table.insert(substitutedKeyValues.requirement, value)

        if SUBSTITUTED.requirement.type == "TALENT_REQUIRED" then
            table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners, 
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] SUBSTITUTED.requirement.value, },
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
                inputValues = { --[[unit]] "player", --[[spellID]] SUBSTITUTED.value, },
                value = value,
            }
        )
    else
        table.insert(substitutedKeyValues.spellcastActive, 0)
    end
    
    return value
end

function this.SelfBuffSubstitutedSetup(value, SUBSTITUTED, iconUIObject)
    value = value * 2

    table.insert(iconUIObject.VisibleState.ListenerGroup.Listeners,
        {
            eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
            inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] SUBSTITUTED.value },
            value = value,
        }
    )
    
    return value
end

function this.ContextIconSetup(instance, icon)
    local listeners = {}
    local validKeys = {}

    local CAST_TYPE, castTypeCount = GetPropertiesOfType(icon, "CAST_TYPE")
    local SUBSTITUTES = GetPropertiesOfType(icon, "SUBSTITUTES")
    local UNITS_NEAR_MIN = GetPropertiesOfType(icon, "UNITS_NEAR_MIN")
    
    local instantCastProperty
    if castTypeCount > 1 then
        for i = 1, castTypeCount do
            if CAST_TYPE[i].value == "INSTANT" and CAST_TYPE[i].requirement ~= nil then
                instantCastProperty = CAST_TYPE[i]
            end
        end
    end


    if SUBSTITUTES ~= nil then
        local value = 1
        local values = {}

        -- UIOBJECT_COMPONENT_STATE_CHANGED
        value = value * 2
        values.UIOBJECT_COMPONENT_STATE_CHANGED = value

        table.insert(listeners,
            {
                eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                inputValues = { --[[uiObject]] IconKeyGet("SPELL", SUBSTITUTES.value, instance.UIObject), --[[componentName]] "CastSoonAlert", },
                value = value,
            }
        )

        -- UNIT_AURA_DURATION_CHANGED
        value = value * 2
        values.UNIT_AURA_DURATION_CHANGED = value

        table.insert(listeners,
            {
                eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] SUBSTITUTES.value, },
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
        if SUBSTITUTES.requirement ~= nil then
            value = value * 2
            values.requirement = value
    
            if SUBSTITUTES.requirement.type == "TALENT_REQUIRED" then
                table.insert(listeners, 
                    {
                        eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                        inputValues = { --[[talentID]] SUBSTITUTES.requirement.value, },
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
            iconObjectID = SUBSTITUTES.value,
            ValueHandler = { validKeys = validKeys, },
            ListenerGroup = { Listeners = listeners, },
        }
    elseif UNITS_NEAR_MIN ~= nil then
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
    elseif instantCastProperty ~= nil then
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