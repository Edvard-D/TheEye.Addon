TheEyeAddon.Managers.Settings = {}
local this = TheEyeAddon.Managers.Settings

this.Account =
{
    savedVariableKey = "TheEyeAddonAccountSettings",
    versionVariableKey = "X-AccountSettingsVersion",
}
this.Character =
{
    savedVariableKey = "TheEyeAddonCharacterSettings",
    versionVariableKey = "X-CharacterSettingsVersion",
}


--[[
Used to convert settings saved in an earlier version of TheEye.Addon so they're compartible with
newer versions. This should only be used to change the location of data that existed in a previous
version or remove data that existed in a previous version that's no longer needed. This should not
be used to add new default data.

NOTE: defining an oldSettingKeyPath without defining a newSettingKeyPath allows you to remove an old
setting completely.

An example of two valid data version converters are defined below:

dataVersionConverters.Account =
{
    ["0.0.0"] = -- oldSettings.version 
    {
        nextVersion = "0.0.1",
        settingKeyPairs =
        {
            {
                oldSettingKeyPath =
                {
                    -- EXAMPLE
                    -- "Debug",
                    -- "testValue",
                },
                newSettingKeyPath =
                {
                    -- EXAMPLE
                    -- "Debug",
                    -- "TestValues",
                    -- "testValue",
                },
            },
        },
    },
    ["0.0.1"] = -- oldSettings.version 
    {
        nextVersion = nil,
        settingKeyPairs =
        {
            {
                oldSettingKeyPath =
                {
                    -- EXAMPLE
                    -- "Debug",
                    -- "testValue",
                },
            },
        },
    },
}
]]
local dataVersionConverters = {}
dataVersionConverters.Account =
{
}

dataVersionConverters.Character =
{
}


function this.Initialize()
    this.gameEvents = { "ADDON_LOADED" }
    TheEyeAddon.Managers.Events.Register(this)
end

local function SettingsAssignUnassigned(fromSettings, toSettings)
    for k,v in pairs(fromSettings) do
        if type(v) == "table" then
            if toSettings[k] == nil then
                toSettings[k] = {}
            end

            SettingsAssignUnassigned(fromSettings[k], toSettings[k])
        elseif toSettings[k] == nil then
            toSettings[k] = fromSettings[k]
        end
    end
end

local function SettingContainerGet(settingKeyPath, settings)
    local container = settings

    for i = 1, #settingKeyPath do
        if i < #settingKeyPath then
            if container[settingKeyPath[i]] == nil then
                container[settingKeyPath[i]] = {}
            end

            container = container[settingKeyPath[i]]
        end
    end

    return container
end

local function SettingConvertDataVersion(settingKeyPair, oldSettings, newSettings)
    local oldSettingContainer = SettingContainerGet(settingKeyPair.oldSettingKeyPath, oldSettings)
    local oldSettingKey = settingKeyPair.oldSettingKeyPath[#settingKeyPair.oldSettingKeyPath]
    
    if settingKeyPair.newSettingKeyPath ~= nil then
        local newSettingContainer = SettingContainerGet(settingKeyPair.newSettingKeyPath, newSettings)
        local newSettingKey = settingKeyPair.newSettingKeyPath[#settingKeyPair.newSettingKeyPath]
        newSettingContainer[newSettingKey] = oldSettingContainer[oldSettingKey]
    end

    oldSettingContainer[oldSettingKey] = nil
end

local function SettingsConvertDataVersion(groupDataVersionConverters, converterVersion, oldSettings, newSettings)
    local dataVersionConverter = groupDataVersionConverters[converterVersion]
    local settingKeyPairs = dataVersionConverter.settingKeyPairs

    for i = 1, #settingKeyPairs do
        SettingConvertDataVersion(settingKeyPairs[i], oldSettings, newSettings)
    end

    local nextVersion = dataVersionConverter.nextVersion
    if nextVersion ~= nil then
        SettingsConvertDataVersion(groupDataVersionConverters, nextVersion, oldSettings, newSettings)
    end
end

local function SettingsGroupConvertDataVersion(settingsGroupKey, oldSettings)
    local newSettings = {}
    local tryConvert = false
    local groupDataVersionConverters = dataVersionConverters[settingsGroupKey]

    if groupDataVersionConverters[oldSettings.version] ~= nil then
        SettingsConvertDataVersion(groupDataVersionConverters, oldSettings.version, oldSettings, newSettings)
    end

    SettingsAssignUnassigned(oldSettings, newSettings)
    return newSettings
end

local function SettingsGroupSetup(settingsGroupKey)
    local settingsGroup = this[settingsGroupKey]
    local currentSettings = _G[settingsGroup.savedVariableKey]
    local currentSettingsVersion = GetAddOnMetadata("TheEyeAddon", settingsGroup.versionVariableKey)

    if currentSettings == nil then
        currentSettings = settingsGroup.Default
        currentSettings.version = currentSettingsVersion
    else
        if currentSettingsVersion ~= currentSettings.version then
            currentSettings = SettingsGroupConvertDataVersion(settingsGroupKey, currentSettings)
            currentSettings.version = currentSettingsVersion
        end

        SettingsAssignUnassigned(settingsGroup.Default, currentSettings)
    end

    _G[settingsGroup.savedVariableKey] = currentSettings
    settingsGroup.Saved = _G[settingsGroup.savedVariableKey]
end

function this:OnEvent(event, addon)
    if addon == "TheEyeAddon" then
        SettingsGroupSetup("Account")
        SettingsGroupSetup("Character")
    end
end