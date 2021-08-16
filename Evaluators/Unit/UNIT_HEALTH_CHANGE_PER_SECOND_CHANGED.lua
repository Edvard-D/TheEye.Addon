TheEye.Core.Evaluators.UNIT_HEALTH_CHANGE_PER_SECOND_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_HEALTH_CHANGE_PER_SECOND_CHANGED
this.isAlwaysActive = true

local EvaluatorRegisterListeningTo = TheEye.Core.Managers.Evaluators.EvaluatorRegisterListeningTo
local GetTime = GetTime
local lastInteractionMaxElapsedTime = 60
local lookbackDurationMax = 10
local lookbackDurationMin = 0.5
local trackedGUIDs = {}
local unitsClearedTimestamp = 0


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit GUID# #UNIT#GUID#
        #LABEL#Lookback Duration# #NUMBER#
    }
}
]]


this.reevaluateEvents =
{
    
}
this.gameEvents =
{
    
}
local combatLogEvents =
{
    "RANGE_DAMAGE",
    "SPELL_DAMAGE",
    "SPELL_HEAL",
    "SPELL_PERIODIC_DAMAGE",
    "SPELL_PERIODIC_HEAL",
    "SWING_DAMAGE",
    "UNIT_DESTROYED",
    "UNIT_DIED",
    "UNIT_DISSIPATES",
}


function this:SetupListeningTo()
    for i = 1, #combatLogEvents do
        EvaluatorRegisterListeningTo(this,
        {
            listeningToKey = "COMBAT_LOG",
            inputValues = { combatLogEvents[i], "_", "_" }
        })
    end
end

local function AmountTotalOverLookbackCalculate(data, lookbackDuration)
    local currentTime = GetTime()
    local total = 0

    for i = 1, #data do
        if currentTime - data[i].timestamp <= lookbackDuration then
            total = total + data[i].amount
        end
    end

    return total
end

local function CalculateCurrentValue(inputValues)
    local guid = inputValues[1]
    local lookbackDuration = inputValues[2]

    if trackedGUIDs[guid] == nil then
        return 0
    end
    
    local data = trackedGUIDs[guid]
    local damageTotal = AmountTotalOverLookbackCalculate(data.damage, lookbackDuration)
    local healTotal = AmountTotalOverLookbackCalculate(data.heal, lookbackDuration)

    local firstInteractionElapsedTime = GetTime() - data.firstInteractionTimestamp
    if lookbackDuration > firstInteractionElapsedTime then
        lookbackDuration = firstInteractionElapsedTime
    end

    if lookbackDuration < lookbackDurationMin then
        lookbackDuration = lookbackDurationMin
    end

    return (healTotal - damageTotal) / lookbackDuration
end

function this:InputGroupSetup(inputGroup)
    local lookbackDuration = inputGroup.inputValues[2]

    if lookbackDuration > lookbackDurationMax then
        lookbackDurationMax = lookbackDuration
    end

    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

local function OldDataRemove(data, currentTime)
    for i = #data, 1, -1 do
        if currentTime - data[i].timestamp > lookbackDurationMax then
            table.remove(data, i)
        end
    end
end

function this:Preprocess(event, eventInputGroup)
    local eventData = eventInputGroup.eventData
    local destGUID = eventData.destGUID
    local currentTime = GetTime()

    if unitsClearedTimestamp ~= currentTime then
        unitsClearedTimestamp = currentTime

        for guid, data in pairs(trackedGUIDs) do
            if data.isDead == true or currentTime - data.lastInteractionTimestamp > lastInteractionMaxElapsedTime then
                trackedGUIDs[guid] = nil
            end
        end
    end

    if trackedGUIDs[destGUID] == nil then
        trackedGUIDs[destGUID] =
        {
            damage = {},
            heal = {},
            firstInteractionTimestamp = currentTime,
        }
    end
    guidData = trackedGUIDs[destGUID]

    if event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" then
        OldDataRemove(guidData.damage, currentTime)
        table.insert(guidData.damage, { timestamp = currentTime, amount = eventData.amount })
        guidData.lastInteractionTimestamp = currentTime
    elseif event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL" then
        OldDataRemove(guidData.heal, currentTime)
        table.insert(guidData.heal, { timestamp = currentTime, amount = eventData.amount })
        guidData.lastInteractionTimestamp = currentTime
    else -- UNIT_DESTROYED, UNIT_DIED, UNIT_DISSIPATES
        trackedGUIDs[destGUID].isDead = true
    end
end

function this:GetKeys(event, eventInputGroup)
    local destGUID = eventInputGroup.eventData.destGUID
    local validKeys = {}
    
    if self.InputGroups == nil then
        return validKeys
    end

    for k,inputGroup in pairs(self.InputGroups) do
        if inputGroup.inputValues[1] == destGUID then
            local lookbackDuration = inputGroup.inputValues[2]
            table.insert(validKeys, table.concat({ destGUID, lookbackDuration }))
        end
    end

    return validKeys
end

function this:Evaluate(inputGroup)
    local healthChangePerSecond = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= healthChangePerSecond then
        inputGroup.currentValue = healthChangePerSecond
        return true, this.key
    end
end