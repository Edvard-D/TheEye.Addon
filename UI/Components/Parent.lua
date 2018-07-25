TheEyeAddon.UI.Components.Parent = {}
local this = TheEyeAddon.UI.Components.Parent

local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local screenWidth = TheEyeAddon.Values.screenSize.width
local screenHeight = TheEyeAddon.Values.screenSize.height
local SortedTableSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable.Setup
local table = table


--[[ #this#TEMPLATE#
{
    childTags = #ARRAY#TAG#
    GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers#NAME#
    #OPTIONAL#sortActionName = #SORTACTION#NAME#
    #OPTIONAL#sortValueComponentName = #COMPONENT#NAME#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    instance.UIObject = uiObject
    instance.ChildDeregister = this.ChildDeregister
    instance.ChildRegister = this.ChildRegister
    instance.DisplayUpdate = this.DisplayUpdate

    -- ValueHandler
    instance.ValueHandler = {}
    SortedTableSetup(
        instance.ValueHandler,
        uiObject,
        instance.sortActionName,
        instance.sortValueComponentName
    )

    -- ListenerGroups
    instance.ListenerGroups =
    {
        DisplayUpdate =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_PARENT_SIZE_CHANGED",
                    inputValues = { --[[parentKey]] uiObject.key },
                },
            }
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_PARENT_SORTRANK_CHANGED",
                    inputValues = { --[[parentKey]] uiObject.key },
                }
            }
        },
    }

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.DisplayUpdate,
        uiObject,
        instance,
        "DisplayUpdate"
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Sort,
        uiObject,
        instance.ValueHandler,
        "Sort"
    )

    instance.ListenerGroups.DisplayUpdate:Activate()
    instance.ListenerGroups.Sort:Activate()
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
        local childFrame = childUIObjects[i].Frame
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
    local frame = self.UIObject.Frame

    if frame ~= nil then
        local childUIObjects = self.ValueHandler.value
        self.ChildArranger.Arrange(frame, childUIObjects)
        frame:SetSizeWithEvent(SizeCalculate(childUIObjects))
    end
end