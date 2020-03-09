TheEye.Core.UI.Components.PlayerCast = {}
local this = TheEye.Core.UI.Components.PlayerCast
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local CastBarClaim = TheEye.Core.UI.Factories.CastBar.Claim
local colors =
{
    background = { 0.1, 0.1, 0.1, 1 },
    immune = { 1, 1, 1, 1 },
    interruptable = { 1, 1, 1, 1 },
}
local GetFiltered = TheEye.Core.Managers.Icons.GetFiltered
local GetPropertiesOfType = TheEye.Core.Managers.Icons.GetPropertiesOfType
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local pairs = pairs
local table = table


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
        "castBar",
        "creator"
    )
end

local function ListenerGroupsSetup(self)
    self.CastListenerGroup =
    {
        Listeners =
        {
            {
                eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                inputValues = { --[[unit]] "player", --[[spellID]] "_", },
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

local function ListenerGroupsTeardown(self)
    self.CastListenerGroup:Deactivate()
end

function this:Modify(frame)
    frame.castbar = CastBarClaim(self.UIObject, frame, self.UIObject.Frame.Dimensions, "player", colors, false, false, false, nil)
    self.castbar = frame.castbar
    ListenerGroupsSetup(self)
end

function this:Demodify(frame)
    frame.castbar:Release()
    self.castbar = nil
    ListenerGroupsTeardown(self)
end

function this:OnCastNotify(event, value)
    if value == true then
        self.castbar:CastSet()
    end
end