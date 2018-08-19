TheEyeAddon.UI.Components.VisibleState = {}
local this = TheEyeAddon.UI.Components.VisibleState
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local DebugLogEntryAdd = TheEyeAddon.Debug.LogEntryAdd
local EnabledStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}

#UIOBJECT#TEMPLATE#DisplayData#
{
    factory = #TheEyeAddon.UI.Factories#NAME#
    DimensionTemplate =
    {
        PointSettings =
        {
            point = #POINT#
            relativePoint = #POINT#
            offsetY = #INT#
        }
    }
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance,
        this.Show,
        this.Hide
    )
    
    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        instance,
        1
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end

function this:Show()
    DebugLogEntryAdd("TheEyeAddon.UI.Components.VisibleState", "Show",
        self.UIObject, self.Component)
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end

function this:Hide()
    DebugLogEntryAdd("TheEyeAddon.UI.Components.VisibleState", "Hide",
        self.UIObject, self.Component)
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end