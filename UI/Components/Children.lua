local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Children= {}
local this = TheEyeAddon.UI.Components.Children

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor.Setup
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local select = select
local SortedTableSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable.Setup
local table = table
local unpack = unpack


TheEyeAddon.UI.Templates:ComponentAddToTag("GROUP", this)

--[[ #this#TEMPLATE#
{
    childTags = { #ARRAY#TAG# }
    GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers#NAME#
    sortActionName = #SORTACTION#NAME#
    sortValueComponentName = #COMPONENT#NAME#
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
]]
function this:Setup(
    instance,
    UIObject
)

    instance.UIObject = UIObject
    instance.Arrange = this.Arrange

    -- ValueHandler
    instance.ValueHandler = {}
    SortedTableSetup:Setup(
        instance.ValueHandler,
        UIObject,
        instance.sortActionName,
        instance.sortValueComponentName
    )

    -- ListenerGroups
    instance.ListenerGroups =
    {
        Arrange =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags }
                },
                {
                    eventName = "UIOBJECT_WITHTAGS_SORTRANK_CHANGED",
                    inputValues = { instance.childTags }
                }
            }
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags }
                }
            }
        },
        UpdateRegisteredChildren =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags },
                }
            }
        }
    }

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Arrange,
        UIObject,
        this.Arrange
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Sort,
        UIObject,
        instance.ValueHandler.Sort
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.UpdateRegisteredChildren,
        UIObject,
        this.UpdateRegisteredChildren
    )

    -- EnabledStateReactor
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        UIObject,
        instance.OnEnable,
        instance.OnDisable
    )
end

function this:OnEnable()
    local listenerGroups = self.ListenerGroups
    for i=1, #listenerGroups do
        listenerGroups[i]:Activate()
    end
end

function this:OnDisable()
    self.ValueHandler:Reset()
    local listenerGroups = self.ListenerGroups
    for i=1, #listenerGroups do
        listenerGroups[i]:Deactivate()
    end
end


-- Arrange
local function GetBoundsFromRects(rects)
	local leftMin = TheEyeAddon.Screen.width
	local bottomMin = TheEyeAddon.Screen.height
	local rightMax = 0
	local topMax = 0

	if #rects > 1 then
		for i = 1, #rects do
			local left, bottom, width, height = unpack(rects[i])

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

local function GetSizeFromRects(rects)
	local leftMin, bottomMin, rightMax, topMax = GetBoundsFromRects(rects)
	local width = rightMax - leftMin
	local height = topMax - bottomMin
	
	return width, height
end

function this:Arrange()
    local children = self.ValueHandler.value
    local frame = self.UIObject.frame
    local groupArranger = self.GroupArranger
    local combinedOffsetX = 0
    local combinedOffsetY = 0
    local childRects = {}

    for i = 1, #children do
        local childFrame = children[i].frame
		local currentOffsetX, currentOffsetY = select(4, childFrame:GetPoint(1))
		
		if currentOffsetX ~= combinedOffsetX or currentOffsetY ~= combinedOffsetY then
			childFrame:ClearAllPoints()
			childFrame:SetPoint(groupArranger.point, frame, groupArranger.relativePoint, combinedOffsetX, combinedOffsetY)
		end

		table.insert(childRects, { childFrame:GetRect() })
		combinedOffsetX, combinedOffsetY = groupArranger.UpdateOffset(combinedOffsetX, combinedOffsetY, childFrame)
	end
	
	if #childRects > 0 then
		frame:SetSizeWithEvent(GetSizeFromRects(childRects))
	else
		frame:SetSizeWithEvent(0, 0)
	end
end


-- UpdateRegisteredChildren
function this:UpdateRegisteredChildren(state, event, ...)
    local childUIObject = ...

    if childUIObject.frame == nil then
        self.ValueHandler:Remove(childUIObject)
    else
        self.ValueHandler:Insert(childUIObject)
    end
end