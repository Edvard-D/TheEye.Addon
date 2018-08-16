TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance                    { #name#STRING#, function Modify(frame), function Demodify(frame) }
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    instance.UIObject = uiObject

    -- FrameStateFunctionCaller
    instance.OnClaim = this.OnClaim
    instance.OnRelease = this.OnRelease

    instance.FrameStateFunctionCaller = {}
    FrameStateFunctionCallerSetup(
        instance.FrameStateFunctionCaller,
        uiObject,
        instance,
        1
    )

    -- StateHandler
    inherited.Setup(
        instance,
        uiObject,
        this.OnValidKey,
        this.OnInvalidKey
    )
    
    instance:Activate()
end

local function CallModify(self)
    if self.state ~= true
        and self.ValueHandler.state == true
        and self.UIObject.Frame ~= nil
        and self.UIObject.Frame.instance ~= nil
        then
        self:Modify(self.UIObject.Frame.instance)
        self.state = true
        SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
    end
end

local function CallDemodify(self)
    if self.state ~= false
        and self.ValueHandler.state == false
        and self.UIObject.Frame ~= nil
        and self.UIObject.Frame.instance ~= nil
        then
        self:Demodify(self.UIObject.Frame.instance)
        self.state = false
        SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
    end
end

function this:OnClaim()
    CallModify(self)
end

function this:OnRelease()
    CallDemodify(self)
end

function this:OnValidKey()
    CallModify(self)
end

function this:OnInvalidKey()
    CallDemodify(self)
end