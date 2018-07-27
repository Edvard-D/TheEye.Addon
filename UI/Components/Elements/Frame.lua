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

    instance.OnUserRegisteredChanged = this.OnUserRegisteredChanged

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

local function UserRegister(self, userName)
    if self.Users == nil then
        self.Users = { userCount = 0 }
    end

    table.insert(self.Users, user)
    self.Users.userCount = self.Users.userCount + 1
    if self.Users.userCount == 1 then
        self.UIObject.frame = self.Factory.Claim(self.UIObject, nil, self.DisplayData)
    end
end

local function UserDeregister(self, userName)
    table.removevalue(self.Users, user)
    self.Users.userCount = self.Users.userCount - 1
    if self.Users.userCount == 0 then
        self.UIObject.frame:Release()
        self.UIObject.frame = nil
    end
end

function this:OnUserRegisteredChanged(isRegistered, userName)
    if isRegistered == true then
        UserRegister(self, userName)
    else
        UserDeregister(self, userName)
    end
end