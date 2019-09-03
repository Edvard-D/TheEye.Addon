TheEyeAddon.UI.Components.TargetAction = {}
local this = TheEyeAddon.UI.Components.TargetAction
local inherited = TheEyeAddon.UI.Components.FrameModifierBase

local GetFiltered = TheEyeAddon.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEyeAddon.Managers.Icons.GetPropertiesOfType
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table
local TargetActionClaim = TheEyeAddon.UI.Factories.TargetAction.Claim


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    unit = #UNIT#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    instance.ValueHandler = { validKeys = { [0] = true, } }
    instance.listenerGroups = {}

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.OnCastNotify = this.OnCastNotify

    inherited.Setup(
        instance,
        "targetAction",
        "creator"
    )
end

local function ListenerGroupSetup(self)
    self.CastListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                inputValues = { --[[unit]] self.unit, --[[spellID]] "_", },
            },
        },
    }
    NotifyBasedFunctionCallerSetup(
        self.CastListenerGroup,
        self,
        "OnCastNotify"
    )
    self.CastListenerGroup:Activate()
end

local function ListenerGroupTeardown(self)
    self.CastListenerGroup:Deactivate()
end

function this:Modify(frame)
    frame.targetAction = TargetActionClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, self.unit, self.dotSpellIDs)
    self.targetAction = frame.targetAction
    ListenerGroupSetup(self)
end

function this:Demodify(frame)
    frame.targetAction:Release()
    self.targetAction = nil
    ListenerGroupTeardown(self)
end

function this:OnCastNotify(event, value)
    if value == true then
        self.targetAction:CastSet()
    end
end