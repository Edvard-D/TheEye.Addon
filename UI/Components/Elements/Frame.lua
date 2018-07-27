TheEyeAddon.UI.Components.Elements.Frame = {}
local this = TheEyeAddon.UI.Components.Elements.Frame

local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #OPTIONAL#DisplayData =
    {
        #OPTIONAL#DimensionTemplate =
        {
            #OPTIONAL#PointSettings =
            {
                #OPTIONAL#point = #POINT#
                #OPTIONAL#relativePoint = #RELATIVEPOINT#
                #OPTIONAL#offsetX = #NUMBER#
                #OPTIONAL#offsetY = #NUMBER#
            }
            #OPTIONAL#width = #NUMBER#
            #OPTIONAL#height = #NUMBER#
        }
    }
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    factory                     UI.Factories
]]
function this.Setup(
    instance,
    uiObject,
    factory
)

    instance.UIObject = uiObject
    instance.Factory = factory

    instance.OnUserRegisteredChanged = this.OnUserRegisteredChanged
    instance.userCount = 0

    uiObject.DisplayData = instance.DisplayData

    -- NotifyBasedFunctionCaller
    instance.NotifyBasedFunctionCaller =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UIOBJECT_FRAME_USER_REGISTERED_CHANGED",
                inputValues = { --[[uiObjectKey]] uiObject.key },
                isInternal = true
            }
        }
    }
    NotifyBasedFunctionCallerSetup(
        instance.NotifyBasedFunctionCaller,
        uiObject,
        instance,
        "OnUserRegisteredChanged"
    )
    instance.NotifyBasedFunctionCaller:Activate()
end

local function UserRegister(self)
    self.userCount = self.userCount + 1
    if self.userCount == 1 then
        self.UIObject.frame = self.Factory.Claim(self.UIObject, nil, self.DisplayData)
        SendCustomEvent("UIOBJECT_SHOWN", self.UIObject)
    end
end

local function UserDeregister(self)
    self.userCount = self.userCount - 1
    if self.userCount == 0 then
        self.UIObject.frame:Release()
        self.UIObject.frame = nil
        SendCustomEvent("UIOBJECT_HIDDEN", self.UIObject)
    end
end

function this:OnUserRegisteredChanged(event, isRegistered)
    if isRegistered == true then
        UserRegister(self)
    else
        UserDeregister(self)
    end
end