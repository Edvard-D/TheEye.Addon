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

--[[ @REFACTOR The state shouldn't change until Modify/Demodify is called, but right now it's
    necessary since frames are created by VisibleState, but the VisibleState of many Primary icons
    depends on the FrameModifier's state to be true. Right now the order of events is:
    * FrameModifier.state = true
    * VisibleState has valid key
    * Frame claimed calling OnClaim
    * FrameModifier calls Modify
]]
local function CallModify(self)
    if self.ValueHandler.state == true then
        if self.UIObject.Frame ~= nil and self.UIObject.Frame.instance ~= nil then
         self:Modify(self.UIObject.Frame.instance)
        end

        if self.state ~= true then
            self.state = true
            SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
        end
    end
end

local function CallDemodify(self)
    if self.ValueHandler.state == false then
        if self.UIObject.Frame ~= nil and self.UIObject.Frame.instance ~= nil then
         self:Demodify(self.UIObject.Frame.instance)
        end
        
        if self.state ~= false then
            self.state = false
            SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
        end
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