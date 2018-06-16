local TheEyeAddon = TheEyeAddon


function TheEyeAddon.UI.Modules:OnStateChange(stateListener, newState)
    local stateGroup = stateListener.stateGroup
    local previousState = stateGroup.currentState
    
    if newState == stateListener.validValue then
        stateGroup.stateKey = stateGroup.stateKey + stateListener.stateValue
    else
        stateGroup.stateKey = stateGroup.stateKey - stateListener.stateValue
    end

    if stateGroup.validKeys[stateGroup.stateKey] ~= nil then
        stateGroup.currentState = true
        if previousState == false or previousState == nil then
            stateGroup:OnValidKey()
        end
    else
        stateGroup.currentState = false
        if previousState == true or previousState == nil then
            stateGroup:OnInvalidKey()
        end
    end
end