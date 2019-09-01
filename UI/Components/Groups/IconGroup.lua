TheEyeAddon.UI.Components.IconGroup = {}
local this = TheEyeAddon.UI.Components.IconGroup
local inherited = TheEyeAddon.UI.Components.Group

local IconsGetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local table = table
local UIObjectSetup = TheEyeAddon.Managers.UI.UIObjectSetup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    filters = { #ICON#PROPERTY# }
    iconDimensionKey = TheEyeAddon.Values.DimensionTemplates.Icon#NAME#
    priorityDisplayers = { #UIOBJECT#ID# }
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

    instance.OnDeactivate = this.OnDeactivate

    instance.Icons = IconsGetFiltered(instance.Filters)
    local icons = instance.Icons

    for i = 1, #icons do
        local icon = icons[i]
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")
        local OBJECT_TYPE = GetPropertiesOfType(icon, "OBJECT_TYPE")

        local iconUIObject =
        {
            tags = { "ICON", table.concat({ OBJECT_TYPE.value, "-", OBJECT_ID.value }), instance.instanceID },
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
            VisibleState =
            {
                ValueHandler = { validKeys = {}, },
                ListenerGroup = { Listeners = {}, },
            },
        }

        icon.UIObject = iconUIObject
        icon.UIObject.instanceID = instance.instanceID
        icon.UIObject.instanceType = instance.instanceType

        -- Talent Required
        local TALENT_REQUIRED, talentCount = GetPropertiesOfType(icon, "TALENT_REQUIRED")
        if talentCount > 0 then
            local validKeys = iconUIObject.EnabledState.ValueHandler.validKeys
            local value = 2

            validKeys[2] = nil

            if talentCount == 1 then
                this.TalentSetup(iconUIObject, validKeys, TALENT_REQUIRED, value)
            else
                for i = 1, #TALENT_REQUIRED do
                    value = this.TalentSetup(iconUIObject, validKeys, TALENT_REQUIRED[i], value)
                end
            end
        end
    end
end

function this:OnDeactivate()
    for i = #self.Icons, 1, -1 do
        local uiObject = self.Icons[i].UIObject
        table.remove(self.Icons, i)
        uiObject:Deactivate()
        TheEyeAddon.UI.Objects.Instances[uiObject.key] = nil
    end
end

function this.IconKeyGet(objectType, objectID, uiObject)
    return table.concat({ "ICON_", objectType, "-", objectID, "_", uiObject.instanceID })
end

function this.TalentSetup(iconUIObject, validKeys, TALENT_REQUIRED, previousValue)
    local value = previousValue * 2

    if TALENT_REQUIRED.isInverse == false then
        validKeys[2 + value] = true
    end
    
    table.insert(iconUIObject.EnabledState.ListenerGroup.Listeners, 
        {
            eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
            inputValues = { --[[talentID]] TALENT_REQUIRED.value, },
            value = value,
        }
    )

    return value 
end