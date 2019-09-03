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
local playerSpec
local table = table


this.Modules =
{
    Groupers = {},
    IconGroups = {},
}


function this.Initialize()
    this.gameEvents =
    {
        "ADDON_LOADED",
        "PLAYER_ENTERING_WORLD",
        "PLAYER_SPECIALIZATION_CHANGED",
    }
    TheEyeAddon.Managers.Events.Register(this)

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
    
    uiObject.Deactivate = function()
        for componentKey,_ in pairs(uiObject) do
            local component = components[componentKey]
            local componentInstance = uiObject[componentKey]
            if component ~= nil and componentInstance ~= nil then
                componentInstance:Deactivate()
            end
        end
    end

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

function this.GrouperAdd(uiObject, setupFunction)
    local grouperKey = uiObject.tags[1]

    this.Modules["Groupers"][grouperKey] =
    {
        uiObject = uiObject,
        Setup = setupFunction,
    }
end

function this.ModuleAdd(key, module)
    this.Modules[key][module.type] = module
end

local function GrouperUIObjectSetup(uiObject)    
    groupers[uiObject.tags[1]] = uiObject

    FormatData(uiObject)
    UIObjectSetup(uiObject)
end

local function IconGroupUIObjectSetup(iconGroupData, maxIcons)
    local parentKey = groupers[iconGroupData.grouper].key

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
            Dimensions = iconGroupData.Dimensions
        },
        PriorityRank =
        {
            ValueHandler =
            {
                validKeys = { [0] = iconGroupData.grouperPriority, }
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
    if iconGroupData.instanceID == nil then
        iconGroupData.instanceID = string.sub(tostring(uiObject), 13, 19)
    end
    uiObject.tags = { "GROUP", iconGroupData.instanceID }
    FormatData(uiObject)

    -- Group Component
    uiObject.Group =
    {
        instanceID = iconGroupData.instanceID,
        instanceType = iconGroupData.type,
        Filters = iconGroupData.Filters,
        IconDimensions = iconGroupData.IconDimensions,
        PriorityDisplayers = iconGroupData.PriorityDisplayers,
        childArranger = TheEyeAddon.Helpers.ChildArrangers[iconGroupData.Group.childArranger],
        maxDisplayedChildren = maxIcons,
        sortActionName = iconGroupData.Group.sortActionName,
        sortValueComponentName = iconGroupData.Group.sortValueComponentName,
    }
    uiObject[groupComponentNames[iconGroupData.type]] = uiObject.Group

    -- Setup
    UIObjectSetup(uiObject)
    
    local icons = uiObject[groupComponentNames[iconGroupData.type]].Icons
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
        DebugLogEntryAdd("TheEyeAddon.Managers.UI", "IconGroupUIObjectSetup: EnabledState Valid Keys", iconUIObject, iconUIObject.EnabledState, table.concat(formattedValidKeys))
        
        local listeners = iconUIObject.EnabledState.ListenerGroup.Listeners
        for i = 1, #listeners do
            DebugLogEntryAdd("TheEyeAddon.Managers.UI", "IconGroupUIObjectSetup: EnabledState Listeners", iconUIObject, iconUIObject.EnabledState, listeners[i].eventEvaluatorKey, table.concat(listeners[i].inputValues), listeners[i].value)
        end

        -- VisibleState
        validKeys = iconUIObject.VisibleState.ValueHandler.validKeys
        formattedValidKeys = {}
        for k,v in pairs(validKeys) do
            table.insert(formattedValidKeys, k)
            table.insert(formattedValidKeys, ", ")
        end
        table.remove(formattedValidKeys, #formattedValidKeys)
        DebugLogEntryAdd("TheEyeAddon.Managers.UI", "IconGroupUIObjectSetup: VisibleState Valid Keys", iconUIObject, iconUIObject.VisibleState, table.concat(formattedValidKeys))

        listeners = iconUIObject.VisibleState.ListenerGroup.Listeners
        for i = 1, #listeners do
            DebugLogEntryAdd("TheEyeAddon.Managers.UI", "IconGroupUIObjectSetup: VisibleState Listeners", iconUIObject, iconUIObject.VisibleState, listeners[i].eventEvaluatorKey, table.concat(listeners[i].inputValues), listeners[i].value)
        end
    end

    return uiObject
end

function this:OnEvent(eventName, ...)
    if eventName == "ADDON_LOADED" then
        local addon = ...

        if addon == "TheEyeAddon" then
            this.scale = TheEyeAddon.Managers.Settings.Character.Saved.UI.scale or TheEyeAddon.Managers.Settings.Character.Default.UI.scale

            for k,v in pairs(this.Modules.Groupers) do
                if v.Setup ~= nil then
                    v.Setup(v.uiObject)
                end
                GrouperUIObjectSetup(v.uiObject)
            end
        end
    else
        newSpec = GetSpecializationInfo(GetSpecialization())
        if newSpec ~= playerSpec then
            playerSpec = newSpec
            
            if eventName == "PLAYER_SPECIALIZATION_CHANGED" then
                for k, module in pairs(this.Modules.IconGroups) do
                    local uiObject = this.Modules.IconGroups[k].UIObject
                    this.Modules.IconGroups[k].UIObject = nil
                    uiObject:Deactivate()
                    TheEyeAddon.UI.Objects.Instances[uiObject.key] = nil
                end
            end
    
            for k, module in pairs(this.Modules.IconGroups) do
                local moduleSettings = TheEyeAddon.Managers.Settings.Character.Saved.UI.Modules[module.type]
                if moduleSettings.enabled == true then
                    module.UIObject = IconGroupUIObjectSetup(module, moduleSettings.maxIcons)
                end
            end
        end
    end
end