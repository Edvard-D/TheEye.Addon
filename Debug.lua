TheEyeAddon.Debug = {}
local this = TheEyeAddon.Debug

local editBox
local filters
local frame
local isEnabled
local logs = {}
local marker
local pairs = pairs
local table = table
local tostring = tostring
local UIObjectHasTag = TheEyeAddon.Tags.UIObjectHasTag


function this.Initialize()
    frame = CreateFrame("Frame", nil, UIParent,"BasicFrameTemplate")
    frame:SetSize(500, 300)
    frame:SetPoint("TOP")
    frame:Hide()

    frame.ScrollFrame = CreateFrame("ScrollFrame", nil, frame, "InputScrollFrameTemplate")
    frame.ScrollFrame:SetPoint("TOPLEFT", 8, -30)
    frame.ScrollFrame:SetPoint("BOTTOMRIGHT", -12, 9)

    editBox = frame.ScrollFrame.EditBox
    editBox:SetFontObject("ChatFontNormal")
    editBox:SetAllPoints(true)
    editBox:SetWidth(frame.ScrollFrame:GetWidth())

    TheEyeAddon.SlashCommands.HandlerRegister(this, "Debug")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "Enable")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "Disable")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "MarkerIncrease")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "LogsClear")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "LogsGet")

    this.MarkerSetup()
    this.FiltersSetup()
    this.Enable()
end

function this.Enable()
    if isEnable ~= true then
        isEnabled = true
    end
end

function this.Disable()
    if isEnable ~= false then
        isEnabled = false
    end
end


-- Markers
function this.MarkerSetup()
    local functionCaller =
    {
        ValueHandler =
        {
            validKeys = { }
        },
        ListenerGroup =
        {
            Listeners = { }
        }
    }
    TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller.Setup(
        functionCaller,
        this.MarkerIncrease,
        this.MarkerIncrease
    )
    functionCaller:Activate()

    this.MarkerReset()
end

function this.MarkerIncrease()
    marker = marker + 1
end

function this.MarkerReset()
    marker = 1
end


-- Filters
--[[
Filters with multiple values using the same key will pass if any value for that key matches. Filters with
multiple keys will pass if all of the keys have at least one valid value. Filters should be formatted as below:

filters =
{
    {
        {
            key = "namespace",
            value ="TheEyeAddon.UI.Components",
        },
        {
            key = "UIObject",
            value ="UIPARENT",
        },
    },
}
]]
function this.FiltersSetup()
    filters =
    {
        {
            {
                key = "namespace",
                value ="TheEyeAddon.UI.Components",
            },
            {
                key = "UIObject",
                value ="HUD_MODULE_PRIMARY",
            },
        },
        {
            {
                key = "namespace",
                value ="TheEyeAddon.UI.Components.Elements.ValueHandlers",
            },
            {
                key = "UIObject",
                value ="PRIMARY",
            },
        },
    }
end

local function IsFilterElementValid(filterElement, namespace, action, uiObject, component)
    if filterElement.key == "namespace" then
        if namespace:find(filterElement.value) ~= nil then
            return true
        end
    elseif filterElement.key == "action" then
        if action:find(filterElement.value) ~= nil then
            return true
        end
    elseif filterElement.key == "UIObject" then
        if uiObject ~= nil and UIObjectHasTag(uiObject, filterElement.value) == true then
            return true
        end
    elseif filterElement.key == "Component" then
        if component ~= nil and component.key:find(filterElement.value) ~= nil then
            return true
        end
    else
        print("No filterElement valid check setup for filterElement key \"" .. tostring(filter.key) .. "\".")
    end

    return false
end

local function IsFilterValid(filter, namespace, action, uiObject, component)
    local filterKeyStates = {}
    for i = 1, #filter do
        local filterElement = filter[i]
        if filterKeyStates[filterElement.key] == nil then
            filterKeyStates[filterElement.key] = false
        end
        if IsFilterElementValid(filterElement, namespace, action, uiObject, component) == true then
            filterKeyStates[filterElement.key] = true
        end
    end

    for k,v in pairs(filterKeyStates) do
        if v == false then
            return false
        end
    end

    return true
end

local function IsLogEntryValid(namespace, action, uiObject, component)
    for i = 1, #filters do
        if IsFilterValid(filters[i], namespace, action, uiObject, component) == true then
            return true
        end
    end

    return false
end


-- Logging
function this.LogEntryAdd(namespace, action, uiObject, component, ...)
    if isEnabled == true and IsLogEntryValid(namespace, action, uiObject, component) == true then
        local logEntry =
        {
            ["marker"] = marker,
            ["namespace"] = namespace,
            ["action"] = action,
            ["UIObject"] = uiObject,
            ["Component"] = component,
            ["values"] = { ... },
        }
        if logs == nil then
            logs = {}
        end
        table.insert(logs, logEntry)
    end
end

local function LogValueFormat(logValue)
    if logValue == nil then 
        return "\t"
    else
        return table.concat({ logValue, "\t" })
    end
end

local function LogEntryFormat(entryPosition, markerEntryPosition, logEntry)
    local formattedLogEntry = {}
    table.insert(formattedLogEntry, LogValueFormat(entryPosition))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.marker))
    table.insert(formattedLogEntry, LogValueFormat(markerEntryPosition))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.namespace))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.action))
    if logEntry.UIObject ~= nil then
        table.insert(formattedLogEntry, LogValueFormat(logEntry.UIObject.key))
    end
    if logEntry.Component ~= nil then
        table.insert(formattedLogEntry, LogValueFormat(logEntry.Component.key))
    end

    local values = logEntry.values
    for i = 1, #values do
        if i ~= #values then
            table.insert(formattedLogEntry, LogValueFormat(tostring(values[i])))
        else
            table.insert(formattedLogEntry, tostring(values[i]))
        end
    end

    table.insert(formattedLogEntry, "\n")
    return formattedLogEntry
end

function this.LogsGet()
    local formattedLogs = {}
    local markerEntryPosition = 0
    for i = 1, #logs do
        if i - 1 > 0 and logs[i].marker ~= logs[i - 1].marker then
            table.insert(formattedLogs, "\n")
            markerEntryPosition = 0
        end
        markerEntryPosition = markerEntryPosition + 1
        table.insertarray(formattedLogs, LogEntryFormat(i, markerEntryPosition, logs[i]))
    end

    editBox:SetText("")
    editBox:SetText(table.concat(formattedLogs))
    frame:Show()
    editBox:HighlightText()
    editBox:SetFocus(true)
end

function this.LogsClear()
    for i = #logs, 1, -1 do
        logs[i] = nil
    end
    editBox:SetText("")
    frame:Hide()
    this.MarkerReset()
end