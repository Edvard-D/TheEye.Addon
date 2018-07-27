TheEyeAddon.Events.Evaluators.UIOBJECT_FRAME_USER_REGISTERED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_FRAME_USER_REGISTERED_CHANGED
this.name = "UIOBJECT_FRAME_USER_REGISTERED_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_FRAME_USER_REGISTERED",
    "UIOBJECT_FRAME_USER_DEREGISTERED"
}


function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject, userName)
    isRegistered = false
    if event == "UIOBJECT_FRAME_USER_REGISTERED" then
        isRegistered = true
    end
    
    return true, this.name, isRegistered, userName
end