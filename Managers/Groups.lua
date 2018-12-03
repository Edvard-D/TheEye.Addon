TheEyeAddon.Managers.Groups = {}
local this = TheEyeAddon.Managers.Groups

local DebugLogEntryAdd = TheEyeAddon.Managers.Debug.LogEntryAdd
local FormatData = TheEyeAddon.Managers.UI.FormatData
local groupComponentNames = {}
local table = table
local UIObjectSetup = TheEyeAddon.Managers.UI.UIObjectSetup


function this.Initialize()
    this.gameEvents = { "ADDON_LOADED" }
    TheEyeAddon.Managers.Events.Register(this)

    groupComponentNames["ROTATION"] = "RotationGroup"
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
                    offsetY = -200,
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

local function IconGroupUIObjectSetup(iconGroup)
    local parentKey = "HUD"

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
        Filters = iconGroup.Filters,
        IconDimensions = iconGroup.IconDimensions,
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

function this:OnEvent(event, addon)
    if addon == "TheEyeAddon" then
        UIParentUIObjectSetup()
        HUDUIObjectSetup()
        
        local iconGroups = TheEyeAddon.Managers.Settings.Character.Saved.IconGroups
        for i = 1, #iconGroups do
            IconGroupUIObjectSetup(iconGroups[i])
        end
    end
end