TheEyeAddon.UI.Components.Elements.Frame = {}
local this = TheEyeAddon.UI.Components.Elements.Frame
this.name = "Frame"
local inherited = TheEyeAddon.UI.Components.Elements.Base

local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent
local VisibleStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
    factory                     UI.Factories
]]
function this.Setup(
    instance,
    factory
)

    inherited.Setup(
        instance
    )

    instance.Factory = factory
    instance.ModifierAdd = this.ModifierAdd
    instance.ModifierRemove = this.ModifierRemove

    instance.UIObject.DisplayData = instance.DisplayData
    instance.UIObject.Frame = instance

    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        instance,
        1
    )
end

function this:OnShow()
    self.state = true
    self.instance = self.Factory.Claim(self.UIObject, nil, self.DisplayData)
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)

    if self.modifiers ~= nil then
        local modifiers = self.modifiers
        for i = 1, #modifiers do
            modifiers[i]:Modify(self.instance)
        end
    end
end

function this:OnHide()
    if self.modifiers ~= nil then
        local modifiers = self.modifiers
        for i = 1, #modifiers do
            modifiers[i]:Demodify(self.instance)
        end
    end

    self.state = false
    self.instance:Release()
    self.instance = nil
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)
end

function this:ModifierAdd(modifier)
    if self.modifiers == nil then
        self.modifiers = {}
    end
    table.insert(self.modifiers, modifier)

    if self.instance ~= nil then
        modifier:Modify(self.instance)
    end
end

function this:ModifierRemove(modifier)
    table.removevalue(self.modifiers, modifier)

    if self.instance ~= nil then
        modifier:Demodify(self.instance)
    end
end