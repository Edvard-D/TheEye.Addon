TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameClaimedStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameClaimedStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller

local EnabledStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    stateListener               { function OnClaim(), function OnRelease() }
]]
function this.Setup(
    instance,
    uiObject,
    stateListener
)

    listener =
    {
        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
        inputValues = { uiObject.key, "Frame" },
        isInternal = true,
    }

    inherited.Setup(
        instance,
        uiObject,
        listener,
        stateListener,
        "OnClaim",
        "OnRelease"
    )

    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        uiObject,
        instance
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end