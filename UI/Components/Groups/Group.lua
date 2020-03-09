TheEye.Core.UI.Components.Group = {}
local this = TheEye.Core.UI.Components.Group
local inherited = TheEye.Core.UI.Elements.Base

local FormatData = TheEye.Core.Managers.UI.FormatData
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local screenWidth = TheEye.Core.Data.screenSize.width
local screenHeight = TheEye.Core.Data.screenSize.height
local SortedTableSetup = TheEye.Core.UI.Elements.ValueHandlers.SortedTable.Setup
local table = table


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    instanceID = #INSTANCE#ID#
    childArranger = TheEye.Core.UI.Objects.ChildArrangers#NAME#
    #OPTIONAL#sortActionName = #SORTACTION#NAME#
    #OPTIONAL#sortValueComponentName = #COMPONENT#NAME#
    #OPTIONAL#maxDisplayedChildren = #NUMBER#
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

    instance.ChildDeregister = this.ChildDeregister
    instance.ChildRegister = this.ChildRegister
    instance.Deactivate = this.Deactivate
    instance.DisplayUpdate = this.DisplayUpdate

    -- ValueHandler
    instance.ValueHandler = {}
    SortedTableSetup(
        instance.ValueHandler,
        instance.sortActionName,
        instance.sortValueComponentName
    )
    instance.childUIObjects = instance.ValueHandler[instance.ValueHandler.valueKey]

    -- ListenerGroups
    instance.ListenerGroups =
    {
        DisplayUpdate =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_PARENT_FRAME_DIMENSIONS_CHANGED",
                    inputValues = { --[[parentKey]] instance.UIObject.key },
                },
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED",
                    inputValues =
                    {
                        --[[parentKey]] instance.UIObject.key,
                        --[[componentKey]] "PriorityRank",
                        --[[valueKey]] "value",
                    },
                    priority = 2,
                },
            },
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED",
                    inputValues =
                    {
                        --[[parentKey]] instance.UIObject.key,
                        --[[componentKey]] "PriorityRank",
                        --[[valueKey]] "value",
                    },
                    priority = 1,
                },
            },
        },
    }

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.DisplayUpdate,
        instance,
        "DisplayUpdate"
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Sort,
        instance.ValueHandler,
        "Sort"
    )

    instance.ListenerGroups.DisplayUpdate:Activate()
    instance.ListenerGroups.Sort:Activate()
end


function this:Deactivate()
    if self.OnDeactivate ~= nil then
        self:OnDeactivate()
    end

    self.ValueHandler:Deactivate()
    self.ListenerGroups.DisplayUpdate:Deactivate()
    self.ListenerGroups.Sort:Deactivate()
end

-- Child Registration
function this:ChildRegister(childUIObject)
    self.ValueHandler:Insert(childUIObject)
    self:DisplayUpdate()
end

function this:ChildDeregister(childUIObject)
    self.ValueHandler:Remove(childUIObject)
    self:DisplayUpdate()
end


-- DisplayUpdate
local function BoundsCalculate(childUIObjects)
    local leftMin = screenWidth
    local bottomMin = screenHeight
	local rightMax = 0
	local topMax = 0

    for i = 1, #childUIObjects do
        local childFrame = childUIObjects[i].Frame.instance
        if childFrame ~= nil then
            local left, bottom, width, height = childFrame:GetRect()

            if width ~= nil and height ~= nil then
                if left < leftMin then leftMin = left end
                if bottom < bottomMin then bottomMin = bottom end
                if width + left > rightMax then rightMax = width + left end
                if height + bottom > topMax then topMax = height + bottom end
            end
        end
    end

	return leftMin, bottomMin, rightMax, topMax
end

local function SizeCalculate(childUIObjects)
	local leftMin, bottomMin, rightMax, topMax = BoundsCalculate(childUIObjects)
	local width = rightMax - leftMin
    local height = topMax - bottomMin
    
	return width, height
end

function this:DisplayUpdate()
    local frame = self.UIObject.Frame.instance
        
    if frame ~= nil then
        local scale = TheEye.Core.Managers.UI.scale
        for i = 1, #self.childUIObjects do
            self.childUIObjects[i].Frame.instance:SetScale(scale)
        end

        self.childArranger.Arrange(frame, self, self.childUIObjects)
        frame:SetSizeWithEvent(SizeCalculate(self.childUIObjects))
    end
end