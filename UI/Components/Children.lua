local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Children= {}
local this = TheEyeAddon.UI.Components.Children

local displayUpdateRequests = {}
local EnabledStateReactorSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor.Setup
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local screenWidth = TheEyeAddon.Values.screenSize.width
local screenHeight = TheEyeAddon.Values.screenSize.height
local select = select
local SortedTableSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable.Setup
local table = table
local unpack = unpack


this.customEvents =
{
    "UPDATE"
}
TheEyeAddon.Events.Coordinator.Register(this)


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
    instance.RequestDisplayUpdate = this.RequestDisplayUpdate
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
        "RequestDisplayUpdate"
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

    -- EnabledStateReactor
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        uiObject,
        instance
    )

    instance.ListenerGroups.RegisteredChildrenUpdate:Activate()
end

function this:OnEnable()
    self.ListenerGroups.DisplayUpdate:Activate()
    self.ListenerGroups.Sort:Activate()
end

function this:OnDisable()
    self.ListenerGroups.DisplayUpdate:Deactivate()
    self.ListenerGroups.Sort:Deactivate()
end


-- DisplayUpdate
function this:RequestDisplayUpdate()
    if table.haskeyvalue(displayUpdateRequests, self) == false then
        table.insert(displayUpdateRequests, self)
    end
end

function this:OnEvent(_, elapsedTime)
    for i = #displayUpdateRequests, 1, -1 do
        displayUpdateRequests[i]:DisplayUpdate()
        table.remove(displayUpdateRequests, i)
    end
end

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