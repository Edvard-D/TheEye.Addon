TheEyeAddon.UI.Components.Elements.Frame = {}
local this = TheEyeAddon.UI.Components.Elements.Frame


--[[ #this#TEMPLATE#
{
    DisplayData =
    {
        DimensionTemplate =
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
        iconObjectType = 
        iconObjectID = 
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

    instance.OnUserRegisteredChanged = this.OnUserRegisteredChanged -- @TODO

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