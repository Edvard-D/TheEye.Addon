TheEye.Core.Managers.Debug = {}
local this = TheEye.Core.Managers.Debug

local editBox
local filters
local frame
local GetTime = GetTime
local logs = {}
local marker
this.markerTag = "LOAD"
local pairs = pairs
local table = table
local tostring = tostring
local UIObjectHasTag = TheEye.Core.Tags.UIObjectHasTag


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

    TheEye.Core.Managers.SlashCommands.HandlerRegister(this, "Debug")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "Enable")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "Disable")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "PrintEnable")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "PrintDisable")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "MarkerIncrease")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "LogsClear")
    TheEye.Core.Managers.SlashCommands.FunctionRegister("Debug", "LogsGet")

    this.MarkerSetup()
    this.FiltersSetup()
end

function this.Enable()
    _G["TheEyeAccountSettings"].Debug.isLoggingEnabled = true
end

function this.Disable()
    _G["TheEyeAccountSettings"].Debug.isLoggingEnabled = false
end

function this.PrintEnable()
    _G["TheEyeAccountSettings"].Debug.isPrintEnabled = true
end

function this.PrintDisable()
    _G["TheEyeAccountSettings"].Debug.isPrintEnabled = false
end


-- Markers
function this.MarkerSetup()
    local functionCaller =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, }
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD", --[[componentName]] "VisibleState" },
                    value = 2,
                    isInternal = true,
                    priority = -math.huge,
                },
            }
        }
    }
    TheEye.Core.UI.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller.Setup(
        functionCaller,
        function()
            this.markerTag = "HUD_ACTIVE"
            this.MarkerIncrease()
        end,
        function()
            this.markerTag = "HUD_INACTIVE"
            this.MarkerIncrease()
        end
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
            value = "TheEye.Core.Managers.UI",
        },
        {
            key = "UIObject",
            value = "8092",
        },
    },
    {
        {
            key = "namespace",
            value = "TheEye.Core.UI.Elements.ValueHandlers.KeyState",
        },
        {
            key = "UIObject",
            value = "8092",
        },
        {
            key = "Component",
            value = "VisibleState",
        },
    },
}
]]
function this.FiltersSetup()
    filters =
    {
    }
end

local function IsFilterElementValid(filterElement, namespace, action, uiObject, component, ...)
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
    elseif filterElement.key == "values" then
        local values = { ... }
        if values ~= nil then
            for i = 1, #values do
                local value = tostring(values[i])
                if value ~= nil and value:find(filterElement.value) ~= nil then
                    return true
                end
            end
        end
    else
        print("No filterElement valid check setup for filterElement key \"" .. tostring(filterElement.key) .. "\".")
    end

    return false
end

local function IsFilterValid(filter, namespace, action, uiObject, component, ...)
    local filterKeyStates = {}
    for i = 1, #filter do
        local filterElement = filter[i]
        if filterKeyStates[filterElement.key] == nil then
            filterKeyStates[filterElement.key] = false
        end
        if filterKeyStates[filterElement.key] ~= true and IsFilterElementValid(filterElement, namespace, action, uiObject, component, ...) == true then
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

local function IsLogEntryValid(namespace, action, uiObject, component, ...)
    if filters ~= nil then
    for i = 1, #filters do
        if IsFilterValid(filters[i], namespace, action, uiObject, component, ...) == true then
            return true
        end
    end
    end

    return false
end


-- Logging
function this.LogEntryAdd(namespace, action, uiObject, component, ...)
    if (_G["TheEyeAccountSettings"] == nil
            or _G["TheEyeAccountSettings"].Debug.isLoggingEnabled == true)
        and IsLogEntryValid(namespace, action, uiObject, component, ...) == true
        then
        local logEntry =
        {
            ["timestamp"] = GetTime(),
            ["marker"] = marker,
            ["markerTag"] = this.markerTag,
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

        if _G["TheEyeAccountSettings"] ~= nil
            and _G["TheEyeAccountSettings"].Debug.isPrintEnabled == true
            then
            local formattedLogEntry = this.LogEntryFormat(nil, nil, logEntry)
            table.remove(formattedLogEntry, 1)
            table.remove(formattedLogEntry, 1)

            local logEntryString = table.concat(formattedLogEntry)
            logEntryString = string.gsub(logEntryString, " __  __ ", " __ ")
            print(logEntryString)
        end
    end
end

local function LogValueFormat(logValue)
    if logValue == nil then 
        return "\t"
    else
        return table.concat({ logValue, "\t" })
    end
end

function this.LogEntryFormat(entryPosition, markerEntryPosition, logEntry)
    local formattedLogEntry = {}
    table.insert(formattedLogEntry, LogValueFormat(logEntry.timestamp))
    table.insert(formattedLogEntry, LogValueFormat(entryPosition))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.marker))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.markerTag))
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

local function LogsFormat(logs)
    local formattedLogs = {}
    local markerEntryPosition = 0
    local markerBreakTag = "`MARKER_BREAK`\n"
    local markerBreakText = {}
    local largestLogEntryLength = 0

    for i = 1, #logs do
        if i - 1 > 0 and logs[i].marker ~= logs[i - 1].marker then
            table.insert(formattedLogs, markerBreakTag)
            markerEntryPosition = 0
        end
        
        markerEntryPosition = markerEntryPosition + 1
        local formattedLogEntry = this.LogEntryFormat(i, markerEntryPosition, logs[i])
        if #formattedLogEntry > largestLogEntryLength then
            largestLogEntryLength = #formattedLogEntry
        end

        table.insertarray(formattedLogs, formattedLogEntry)
    end

    for i = 1, largestLogEntryLength - 2 do
        table.insert(markerBreakText, "`\t")
    end
    table.insert(markerBreakText, "`\n")
    markerBreakText = table.concat(markerBreakText)

    for i = 1, #formattedLogs do
        if formattedLogs[i] == markerBreakTag then
            formattedLogs[i] = markerBreakText
        end
    end

    return formattedLogs
end

function this.LogsGet()
    if _G["TheEyeAccountSettings"].Debug.isLoggingEnabled == true then
        editBox:SetText("")
        editBox:SetText(table.concat(LogsFormat(logs)))
        frame:Show()
        editBox:HighlightText()
        editBox:SetFocus(true)
    else
        this.Enable()
        print("No logs exist as debug logging was disabled. Debug logging has now been enabled.")
    end
end

function this.LogsClear()
    for i = #logs, 1, -1 do
        logs[i] = nil
    end
    editBox:SetText("")
    frame:Hide()
    this.MarkerReset()
end