local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Children= {}
local this = TheEyeAddon.UI.Components.Children

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
    instance.DisplayUpdate = this.DisplayUpdate
    instance.RegisteredChildrenUpdate = this.RegisteredChildrenUpdate

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
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_RESIZED",
                    inputValues = instance.childTags,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_VISIBILE_CHANGED",
                    inputValues = instance.childTags,
                }
            }
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_SORTRANK_CHANGED",
                    inputValues = instance.childTags,
                }
            }
        },
        RegisteredChildrenUpdate =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_VISIBILE_CHANGED",
                    inputValues = instance.childTags,
                }
            }
        }
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

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.RegisteredChildrenUpdate,
        uiObject,
        instance,
        "RegisteredChildrenUpdate"
    )

    instance.ListenerGroups.RegisteredChildrenUpdate:Activate()
    instance.ListenerGroups.DisplayUpdate:Activate()
    instance.ListenerGroups.Sort:Activate()
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


-- RegisteredChildrenUpdate
function this:RegisteredChildrenUpdate(event, childUIObject)
    -- False state for ValueHandlers.KeyState is nil.
    if childUIObject.VisibleState.ValueHandler.state == false then
        self.ValueHandler:Remove(childUIObject)
    else
        self.ValueHandler:Insert(childUIObject)
    end
end