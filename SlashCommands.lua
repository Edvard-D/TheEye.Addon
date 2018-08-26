TheEyeAddon.SlashCommands = {}
local this = TheEyeAddon.SlashCommands

local handlers = {}
local string = string


function this.Initialize()
    SLASH_THEEYE1 = "/theeye"
    SlashCmdList["THEEYE"] = function(message)
        local handlerKey, functionKey = select(3, string.find(message, "%s?(%w+)%s?(.*)"))
        local handler = handlers[handlerKey]
        handler.instance[handler.functionKeys[functionKey]](handler.instance)
    end
end

function this.HandlerRegister(instance, handlerKey)
    if handlers[handlerKey] == nil then
        handlers[handlerKey] = {}
    end
    handlers[handlerKey].instance = instance
end

function this.FunctionRegister(handlerKey, functionKey)
    if handlers[handlerKey].functionKeys == nil then
        handlers[handlerKey].functionKeys = {}
    end
    handlers[handlerKey].functionKeys[functionKey] = functionKey
end

function this.HandlerDeregister(handlerKey)
    handlers[handlerKey] = nil
end