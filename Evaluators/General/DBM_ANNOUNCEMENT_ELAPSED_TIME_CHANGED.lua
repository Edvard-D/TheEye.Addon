TheEye.Core.Evaluators.DBM_ANNOUNCEMENT_ELAPSED_TIME_CHANGED = {}
local this = TheEye.Core.Evaluators.DBM_ANNOUNCEMENT_ELAPSED_TIME_CHANGED

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEye.Core.Helpers.Timers.InputGroupElapsedTimerStart
local lastEventData
local lastEventTimeStamp = 0
local select = select


--[[ #this#TEMPLATE#
{
    inputValues = nil
}
]]


this.customEvents =
{
    "DBM_ANNOUNCEMENT_ELAPSED_TIMER_END"
}
this.dbmEvents =
{
    "DBM_Announce",
}


local function TimerStart(inputGroup, elapsedTime)
    InputGroupElapsedTimerStart(inputGroup, elapsedTime, "DBM_ANNOUNCEMENT_ELAPSED_TIMER_END", inputGroup.eventData)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = math.huge
end

function this:GetKey()
    return "default"
end

function this:Evaluate(inputGroup, event, ...)
    if event == "DBM_Announce" then
        local isSpecial = select(6, ...)

        if isSpecial == true then
            lastEventTimeStamp = GetTime()
            lastEventData = 
            {
                message = select(1, ...),
                iconFileID = select(2, ...),
                type = select(3, ...),
                spellID = select(4, ...),
                modID = select(5, ...),
            }
            inputGroup.eventData = lastEventData
        end
    end

    local elapsedTime = GetTime() - lastEventTimeStamp

    if elapsedTime ~= inputGroup.currentValue then
        inputGroup.currentValue = elapsedTime
        TimerStart(inputGroup, elapsedTime)
        return true, this.key
    end
end