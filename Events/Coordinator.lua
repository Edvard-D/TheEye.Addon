local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Evaluators = {} }
local Evaluators = TheEyeAddon.Events.Coordinator.Evaluators


local frame = CreateFrame("Frame", nil, UIParent)
local function HandleEvent(self, eventName)
    for i,evaluator in ipairs(Evaluators[eventName]) do
        TheEyeAddon.Events.Evaluators:EvaluateState(evaluator, eventName)
    end
end
frame:SetScript("OnEvent", HandleEvent)


function TheEyeAddon.Events.Coordinator:RegisterEvaluator(evaluator)
    for i,eventName in ipairs(evaluator.registerTo) do
        if Evaluators[eventName] == nil then
            Evaluators[eventName] = { evaluator }
            frame:RegisterEvent(eventName)
        else
            table.insert(Evaluators[eventName], evaluator)
        end

        if Evaluators[eventName].evaluatorCount == nil then
            Evaluators[eventName].evaluatorCount = 0
        end
        Evaluators[eventName].evaluatorCount = Evaluators[eventName].evaluatorCount + 1
    end
end

function TheEyeAddon.Events.Coordinator:UnregisterEvaluator(evaluator)
    for i,eventName in ipairs(evaluator.registerTo) do
        table.removevalue(Evaluators[eventName], evaluator)
        
        Evaluators[eventName].evaluatorCount = Evaluators[eventName].evaluatorCount - 1
        if Evaluators[eventName].evaluatorCount == 0 then
            frame:UnregisterEvent(eventName)
        elseif Evaluators[eventName].evaluatorCount < 0 then
            error("Registered evaluators set to " ..
                tostring(Evaluators[eventName].evaluatorCount) ..
                " but should never be below 0.")
        end
    end
end