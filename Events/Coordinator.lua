local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Evaluators = {} }
local Evaluators = TheEyeAddon.Events.Coordinator.Evaluators

local ipairs = ipairs
local table = table


local frame = CreateFrame("Frame", nil, UIParent)
local function HandleEvent(self, eventName, ...)
    print ("Coordinator:HandleEvent    " .. eventName) -- DEBUG
    for i,evaluator in ipairs(Evaluators[eventName]) do
        TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, eventName, ...)
    end
end
frame:SetScript("OnEvent", HandleEvent)

local function InsertEvaluator(eventName, evaluator, isGameEvent)
    if Evaluators[eventName] == nil then
        Evaluators[eventName] = { evaluator }

        if isGameEvent == true then
            print ("RegisterEvent    " .. eventName) -- DEBUG
            frame:RegisterEvent(eventName)
        end
    else
        table.insert(Evaluators[eventName], evaluator)
    end

    local eventGroup = Evaluators[eventName]
    if eventGroup.evaluatorCount == nil then
        eventGroup.evaluatorCount = 0
    end
    eventGroup.evaluatorCount = eventGroup.evaluatorCount + 1
end

local function RemoveEvaluator(eventName, evaluator, isGameEvent)
    local eventGroup = Evaluators[eventName]
    table.removevalue(eventGroup, evaluator)
    
    eventGroup.evaluatorCount = eventGroup.evaluatorCount - 1
    if isGameEvent == true and eventGroup.evaluatorCount == 0 then
        print ("UnregisterEvent    " .. eventName) -- DEBUG
        frame:UnregisterEvent(eventName)
        Evaluators[eventName] = nil
        eventGroup = nil
    end
end


function TheEyeAddon.Events.Coordinator:RegisterEvaluator(evaluator)
    if evaluator.gameEvents ~= nil then
        for i,eventName in ipairs(evaluator.gameEvents) do
            InsertEvaluator(eventName, evaluator, true)
        end
    end

    if evaluator.customEvents ~= nil then
        for i,eventName in ipairs(evaluator.customEvents) do
            InsertEvaluator(eventName, evaluator, false)
        end
    end
end

function TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    if evaluator.gameEvents ~= nil then
        for i,eventName in ipairs(evaluator.gameEvents) do
            RemoveEvaluator(eventName, evaluator, true)
        end
    end
    
    if evaluator.customEvents ~= nil then
        for i,eventName in ipairs(evaluator.customEvents) do
            RemoveEvaluator(eventName, evaluator, false)
        end
    end
end

function TheEyeAddon.Events.Coordinator:SendCustomEvent(eventName, ...)
    if Evaluators[eventName] ~= nil then
        HandleEvent(frame, eventName, ...)
    end
end