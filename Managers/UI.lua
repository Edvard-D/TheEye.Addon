TheEyeAddon.Managers.UI = {}
local this = TheEyeAddon.Managers.UI

local DebugLogEntryAdd = TheEyeAddon.Managers.Debug.LogEntryAdd
local groupComponentNames =
{
    ACTIVE = "ActiveGroup",
    COOLDOWN = "CooldownGroup",
    ROTATION = "RotationGroup",
    SITUATIONAL = "SituationalGroup",
}
local groupers = {}
local table = table


function this.Initialize()
    this.inputValues = { --[[addonName]] "TheEyeAddon" }
    TheEyeAddon.Managers.Evaluators.ListenerRegister("ADDON_LOADED", this)

    CastingBarFrame:UnregisterAllEvents()
end

local function FormatData(uiObject)
    local key = table.concat(uiObject.tags, "_")
    uiObject.key = key
    TheEyeAddon.UI.Objects.Instances[key] = uiObject

    local searchableTags = {}
    local tags = uiObject.tags
    for i = 1, #tags do
        searchableTags[tags[i]] = true
    end
    uiObject.tags = searchableTags
end

local function UIObjectSetup(uiObject)
    local components = TheEyeAddon.UI.Components
    local pairs = pairs

    this.currentUIObject = uiObject

    for componentKey,_ in pairs(uiObject) do
        local component = components[componentKey]
        local componentInstance = uiObject[componentKey]
        if component ~= nil and componentInstance.wasSetup == nil then
            this.currentComponent = componentInstance
            componentInstance.key = componentKey

            component.Setup(componentInstance, uiObject)
            componentInstance.wasSetup = true
        end
    end
end

local function UIParentUIObjectSetup()
    local uiObject =
    {
        tags = { "UIPARENT" },
        EnabledState =
        {
            ValueHandler =
            {
                validKeys = { [6] = true },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "ADDON_LOADED",
                        inputValues = { --[[addonName]] "TheEyeAddon" },
                        value = 2,
                    },
                    {
                        eventEvaluatorKey = "GAMEDATA_LOADED_CHANGED",
                        inputValues = nil,
                        value = 4,
                    },
                },
            },
        },
        Frame =
        {
            Dimensions =
            {
                PointSettings =
                {
                    point = "CENTER",
                    relativePoint = "CENTER",
                    offsetX = TheEyeAddon.Managers.Settings.Character.Saved.uiParentOffset.X or TheEyeAddon.Managers.Settings.Character.Default.uiParentOffset.X,
                    offsetY = TheEyeAddon.Managers.Settings.Character.Saved.uiParentOffset.Y or TheEyeAddon.Managers.Settings.Character.Default.uiParentOffset.Y,
                },
            },
        },
        Group =
        {
            childArranger = TheEyeAddon.Helpers.ChildArrangers.Delegate,
        },
        VisibleState =
        {
            ValueHandler =
            {
                validKeys = { [2] = true },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UNIT_SPEC_CHANGED",
                        inputValues = { --[[unit]] "player", --[[specID]] 258 },
                        value = 2,
                    },
                },
            },
        },
    }

    FormatData(uiObject)
    UIObjectSetup(uiObject)
end

local function HUDUIObjectSetup()
    local parentKey = "UIPARENT"

    local uiObject =
    {
        tags = { "HUD", },
        Child =
        {
            parentKey = parentKey,
        },
        EnabledState =
        {
            ValueHandler =
            {
                validKeys = { [2] = true },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                        inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                        value = 2,
                    },
                },
            },
        },
        Frame =
        {
            Dimensions =
            {
                PointSettings =
                {
                    point = "TOP",
                    relativePoint = "CENTER",
                    offsetY = -75,
                },
            },
        },
        Group =
        {
            childArranger = TheEyeAddon.Helpers.ChildArrangers.Delegate,
        },
        VisibleState =
        {
            ValueHandler =
            {
                validKeys = { [14] = true, },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UNIT_AFFECTING_COMBAT_CHANGED",
                        inputValues = { --[[unit]] "player" },
                        value = 2,
                    },
                    {
                        eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                        inputValues = { --[[unit]] "player" },
                        comparisonValues =
                        {
                            value = 0,
                            type = "GreaterThan"
                        },
                        value = 4,
                    },
                    {
                        eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                        inputValues = { --[[unit]] "target" },
                        comparisonValues =
                        {
                            value = 0,
                            type = "GreaterThan"
                        },
                        value = 8,
                    },
                },
            },
        },
    }
    
    FormatData(uiObject)
    UIObjectSetup(uiObject)
end

local function GrouperUIObjectSetup(tag, pointSettings)
    local grouper = {}
    local parentKey = "HUD"

    grouper.UIObject =
    {
        tags = { tag },
        Child =
        {
            parentKey = parentKey,
        },
        EnabledState =
        {
            ValueHandler =
            {
                validKeys = { [2] = true },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                        inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                        value = 2,
                    },
                },
            },
        },
        Frame =
        {
            Dimensions =
            {
                PointSettings = pointSettings,
            },
        },
        Group =
        {
            childArranger = TheEyeAddon.Helpers.ChildArrangers.TopToBottom,
            childPadding = 5,
            sortActionName = "SortDescending",
            sortValueComponentName = "PriorityRank",
        },
        VisibleState =
        {
            ValueHandler =
            {
                validKeys = { [0] = true },
            },
        },
    }

    FormatData(grouper.UIObject)
    UIObjectSetup(grouper.UIObject)

    return grouper
end

local function IconGroupUIObjectSetup(iconGroup)
    local parentKey = groupers[iconGroup.grouper].UIObject.key

    local uiObject =
    {
        Child =
        {
            parentKey = parentKey,
        },
        EnabledState =
        {
            ValueHandler =
            {
                validKeys = { [2] = true },
            },
            ListenerGroup =
            {
                Listeners =
                {
                    {
                        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                        inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                        value = 2,
                    },
                },
            },
        },
        Frame =
        {
            Dimensions = iconGroup.Dimensions
        },
        PriorityRank =
        {
            ValueHandler =
            {
                validKeys = { [0] = iconGroup.grouperPriority, }
            },
        },
        VisibleState =
        {
            ValueHandler =
            {
                validKeys = { [0] = true },
            },
        }
    }

    -- Key
    if iconGroup.instanceID == nil then
        iconGroup.instanceID = string.sub(tostring(uiObject), 13, 19)
    end
    uiObject.tags = { "GROUP", iconGroup.instanceID }
    FormatData(uiObject)

    -- Group Component
    uiObject.Group =
    {
        instanceID = iconGroup.instanceID,
        instanceType = iconGroup.type,
        Filters = iconGroup.Filters,
        IconDimensions = iconGroup.IconDimensions,
        PriorityDisplayers = iconGroup.PriorityDisplayers,
        childArranger = TheEyeAddon.Helpers.ChildArrangers[iconGroup.Group.childArranger],
        sortActionName = iconGroup.Group.sortActionName,
        sortValueComponentName = iconGroup.Group.sortValueComponentName,
    }
    uiObject[groupComponentNames[iconGroup.type]] = uiObject.Group

    -- Setup
    UIObjectSetup(uiObject)
    
    local icons = uiObject[groupComponentNames[iconGroup.type]].Icons
    for i = 1, #icons do
        local iconUIObject = icons[i].UIObject
        FormatData(iconUIObject)
        UIObjectSetup(iconUIObject)

        -- DEBUG
        -- EnabledState
        local validKeys = iconUIObject.EnabledState.ValueHandler.validKeys
        local formattedValidKeys = {}
        for k,v in pairs(validKeys) do
            table.insert(formattedValidKeys, k)
            table.insert(formattedValidKeys, ", ")
        end
        table.remove(formattedValidKeys, #formattedValidKeys)
        DebugLogEntryAdd("TheEyeAddon.Managers.Groups", "IconGroupUIObjectSetup: EnabledState Valid Keys", iconUIObject, iconUIObject.EnabledState, table.concat(formattedValidKeys))
        
        local listeners = iconUIObject.EnabledState.ListenerGroup.Listeners
        for i = 1, #listeners do
            DebugLogEntryAdd("TheEyeAddon.Managers.Groups", "IconGroupUIObjectSetup: EnabledState Listeners", iconUIObject, iconUIObject.EnabledState, listeners[i].eventEvaluatorKey, table.concat(listeners[i].inputValues), listeners[i].value)
        end

        -- VisibleState
        validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
        formattedValidKeys = {}
        for k,v in pairs(validKeys) do
            table.insert(formattedValidKeys, k)
            table.insert(formattedValidKeys, ", ")
        end
        table.remove(formattedValidKeys, #formattedValidKeys)
        DebugLogEntryAdd("TheEyeAddon.Managers.Groups", "IconGroupUIObjectSetup: VisibleState Valid Keys", iconUIObject, iconUIObject.VisibleState, table.concat(formattedValidKeys))

        listeners = iconUIObject.VisibleState.ListenerGroup.Listeners
        for i = 1, #listeners do
            DebugLogEntryAdd("TheEyeAddon.Managers.Groups", "IconGroupUIObjectSetup: VisibleState Listeners", iconUIObject, iconUIObject.VisibleState, listeners[i].eventEvaluatorKey, table.concat(listeners[i].inputValues), listeners[i].value)
        end
    end
    uiObject[groupComponentNames[iconGroup.type]].Icons = nil
end

function this:Notify(event, addon)
    UIParentUIObjectSetup()
    HUDUIObjectSetup()
    
    groupers =
    {
        LEFT = GrouperUIObjectSetup(
            "LEFT",
            {
                point = "TOPRIGHT",
                relativePoint = "TOP",
                offsetX = -32.5,
                offsetY = -5,
            }
        ),
        CENTER = GrouperUIObjectSetup(
            "CENTER",
            {
                point = "TOP",
                relativePoint = "TOP",
            }
        ),
        RIGHT = GrouperUIObjectSetup(
            "RIGHT",
            {
                point = "TOPLEFT",
                relativePoint = "TOP",
                offsetX = 32.5,
                offsetY = -5,
            }
        ),
    }

    local iconGroups = TheEyeAddon.Managers.Settings.Character.Saved.IconGroups
    for i = 1, #iconGroups do
        IconGroupUIObjectSetup(iconGroups[i])
    end
end