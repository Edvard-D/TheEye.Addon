TheEye.Core.UI.Components.Child = {}
local this = TheEye.Core.UI.Components.Child
local inherited = TheEye.Core.UI.Elements.Base

local FrameStateFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local UIObjectInstances = TheEye.Core.UI.Objects.Instances


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    parentKey = #UIOBJECT#KEY#
    frameAttachPointPath = { #OPTIONAL#STRING# }
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance
    )

    instance.Deactivate = this.Deactivate

    -- FrameStateFunctionCaller
    instance.OnClaim = this.OnClaim
    instance.OnRelease = this.OnRelease

    instance.FrameStateFunctionCaller = {}
    FrameStateFunctionCallerSetup(
        instance.FrameStateFunctionCaller,
        instance,
        2
    )
end

function this:Deactivate()
    self.FrameStateFunctionCaller:Deactivate()
end

function this:OnClaim()
    if self.frameAttachPointPath == nil then
        UIObjectInstances[self.parentKey].Group:ChildRegister(self.UIObject)
    else
        local selectedTable = UIObjectInstances[self.parentKey].Frame.instance

        for i = 1, #self.frameAttachPointPath do
            selectedTable = selectedTable[self.frameAttachPointPath[i]]
        end

        local attachPointFrame = selectedTable
        local pointSettings = self.UIObject.Frame.Dimensions.PointSettings

        if pointSettings ~= nil then
            self.UIObject.Frame.instance:SetPoint(
                pointSettings.point,
                attachPointFrame,
                pointSettings.relativePoint,
                pointSettings.offsetX or 0,
                pointSettings.offsetY or 0
            )
        else
            self.UIObject.Frame.instance:SetAllPoints(attachPointFrame)
        end
    end
end

function this:OnRelease()
    if self.frameAttachPointPath == nil then
        UIObjectInstances[self.parentKey].Group:ChildDeregister(self.UIObject)
    end
end