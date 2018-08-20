TheEyeAddon.Debug = {}
local this = TheEyeAddon.Debug

local editBox
local frame
local isEnabled
local logs
local table = table


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
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "LogsClear")
    TheEyeAddon.SlashCommands.FunctionRegister("Debug", "LogsGet")

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

function this.LogEntryAdd(namespace, action, uiObject, component, ...)
    if isEnabled == true then
        local logEntry =
        {
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

function this.LogsClear()
    for i = #logs, 1, -1 do
        logs[i] = nil
    end
    editBox:SetText("")
    frame:Hide()
end

local function LogValueFormat(logValue)
    if logValue == nil then 
        return "\t"
    else
        return table.concat({ logValue, "\t" })
    end
end

local function LogEntryFormat(entryPosition, logEntry)
    local formattedLogEntry = {}
    table.insert(formattedLogEntry, LogValueFormat(entryPosition))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.namespace))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.action))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.UIObject.key))
    table.insert(formattedLogEntry, LogValueFormat(logEntry.Component.key))

    local values = logEntry.values
    for i = 1, #values do
        if i ~= #values then
            table.insert(formattedLogEntry, LogValueFormat(values[i]))
        else
            table.insert(formattedLogEntry, values[i])
        end
    end

    table.insert(formattedLogEntry, "\n")
    return formattedLogEntry
end

function this.LogsGet()
    local formattedLogs = {}
    for i = 1, #logs do
        table.insertarray(formattedLogs, LogEntryFormat(i, logs[i]))
    end

    editBox:SetText(table.concat(formattedLogs))
    frame:Show()
    editBox:HighlightText()
    editBox:SetFocus(true)
end