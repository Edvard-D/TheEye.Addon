TheEyeAddon.UI.Components.IconGroup = {}
local this = TheEyeAddon.UI.Components.IconGroup
local inherited = TheEyeAddon.UI.Components.GroupBase

local IconsGetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local table = table
local UIObjectSetup = TheEyeAddon.Managers.UI.UIObjectSetup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    filters = { #ICON#PROPERTY# }
    iconDimensionKey = TheEyeAddon.Values.DimensionTemplates.Icon#NAME#
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

    instance.Icons = IconsGetFiltered(instance.Filters)
    local icons = instance.Icons

    for i = 1, #icons do
        local icon = icons[i]
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")
        local OBJECT_TYPE = GetPropertiesOfType(icon, "OBJECT_TYPE")

        local iconUIObject =
        {
            tags = { "ICON", table.concat({ OBJECT_TYPE.value, "-", OBJECT_ID.value }), string.sub(tostring(instance.UIObject), 13, 19) },
            Child =
            {
                parentKey = instance.UIObject.key,
            },
            EnabledState =
            {
                ValueHandler =
                {
                    validKeys = { [2] = true, },
                },
                ListenerGroup =
                {
                    Listeners =
                    {
                        {
                            eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                            inputValues = { --[[uiObjectKey]] instance.UIObject.key, --[[componentName]] "VisibleState" },
                            value = 2,
                        },
                    },
                },
            },
            Frame =
            {
                Dimensions = instance.IconDimensions,
            },
            Icon =
            {
                iconObjectID = OBJECT_ID.value,
                iconObjectType = OBJECT_TYPE.value,
            },
        }

        -- Talent Required
        local talentData, talentCount = GetPropertiesOfType(icon, "TALENT_REQUIRED")
        if talentCount > 0 then
            local validKeys = iconUIObject.EnabledState.ValueHandler.validKeys
            local value = 2

            validKeys[2] = nil

            if talentCount == 1 then
                this.TalentSetup(iconUIObject, validKeys, talentData, value)
            else
                for i = 1, #talentData do
                    value = this.TalentSetup(iconUIObject, validKeys, talentData[i], value)
                end
            end
        end

        icon.UIObject = iconUIObject
    end
end

function this.IconKeyGet(objectType, objectID, uiObject)
    return table.concat({ "ICON_", objectType, "-", objectID, "_", string.sub(tostring(uiObject), 13, 19) })
end

function this.TalentSetup(iconUIObject, validKeys, talentData, previousValue)
    local value = previousValue * 2
    validKeys[2 + value] = true
    table.insert(iconUIObject.EnabledState.ListenerGroup.Listeners, 
        {
            eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
            inputValues = { --[[talentID]] talentData.value, },
            value = value,
        }
    )

    return value 
end