local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Evaluators = {} }
local Evaluators = TheEyeAddon.Events.Coordinator.Evaluators


local frame = CreateFrame("Frame", nil, UIParent)
local function HandleEvent(self, eventName, ...)
    for i,evaluator in ipairs(Evaluators[eventName]) do
        TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, eventName, ...)
    end
end
frame:SetScript("OnEvent", HandleEvent)

local function InsertEvaluator(eventName, evaluator, isGameEvent)
    if Evaluators[eventName] == nil then
        Evaluators[eventName] = { evaluator }

        if isGameEvent == true then
            frame:RegisterEvent(eventName)
        end
    else
        table.insert(Evaluators[eventName], evaluator)
    end

    if Evaluators[eventName].evaluatorCount == nil then
        Evaluators[eventName].evaluatorCount = 0
    end
    Evaluators[eventName].evaluatorCount = Evaluators[eventName].evaluatorCount + 1
end

local function RemoveEvaluator(eventName, evaluator, isGameEvent)
    table.removevalue(Evaluators[eventName], evaluator)
    
    Evaluators[eventName].evaluatorCount = Evaluators[eventName].evaluatorCount - 1
    if isGameEvent == true and Evaluators[eventName].evaluatorCount == 0 then
        frame:UnregisterEvent(eventName)
    elseif Evaluators[eventName].evaluatorCount < 0 then -- DEBUG
        error("Registered evaluators set to " ..
            tostring(Evaluators[eventName].evaluatorCount) ..
            " but should never be below 0.")
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
    HandleEvent(frame, eventName, ...)
end