local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Children= {}
local this = TheEyeAddon.UI.Components.Children
this.name = "Children"

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor.Setup
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local select = select
local SortedTableSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable.Setup
local table = table
local unpack = unpack


TheEyeAddon.UI.Templates.ComponentAddToTag("GROUP", this)

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
    instance.Arrange = this.Arrange
    instance.UpdateRegisteredChildren = this.UpdateRegisteredChildren

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
        Arrange =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_SORTRANK_CHANGED",
                    inputValues = instance.childTags,
                }
            }
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_WITH_TAGS_VISIBILE_CHANGED",
                    inputValues = instance.childTags,
                }
            }
        },
        UpdateRegisteredChildren =
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
        instance.ListenerGroups.Arrange,
        uiObject,
        instance,
        "Arrange"
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Sort,
        uiObject,
        instance.ValueHandler,
        "Sort"
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.UpdateRegisteredChildren,
        uiObject,
        instance,
        "UpdateRegisteredChildren"
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
end

function this:OnEnable()
    for k,listenerGroup in pairs(self.ListenerGroups) do
        listenerGroup:Activate()
    end
end

function this:OnDisable()
    for k,listenerGroup in pairs(self.ListenerGroups) do
        listenerGroup:Deactivate()
    end
end


-- Arrange
local function GetBoundsFromRects(rects)
	local leftMin = TheEyeAddon.Values.screenSize.width
	local bottomMin = TheEyeAddon.Values.screenSize.height
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
    local frame = self.UIObject.Frame

    if frame ~= nil then 
        local children = self.ValueHandler.value
        local groupArranger = self.GroupArranger
        local combinedOffsetX = 0
        local combinedOffsetY = 0
        local childRects = {}

        for i = 1, #children do
            local childUIObject = children[i]
            local childFrame = childUIObject.Frame
            local currentOffsetX, currentOffsetY = select(4, childFrame:GetPoint(1))
            
            if currentOffsetX ~= combinedOffsetX or currentOffsetY ~= combinedOffsetY then
                local childPointSettings = childFrame.UIObject.DisplayData.DimensionTemplate.PointSettings
                childFrame:ClearAllPoints()
                groupArranger.SetPoint(frame, childFrame, childPointSettings, combinedOffsetX, combinedOffsetY)
            end

            table.insert(childRects, { childFrame:GetRect() })
            combinedOffsetX, combinedOffsetY = groupArranger.UpdateOffset(childFrame, combinedOffsetX, combinedOffsetY)
        end
        
        if #childRects > 0 then
            frame:SetSizeWithEvent(GetSizeFromRects(childRects))
        else
            frame:SetSizeWithEvent(0, 0)
        end
    end
end


-- UpdateRegisteredChildren
function this:UpdateRegisteredChildren(event, ...)
    local childUIObject = ...

    if childUIObject.VisibleState.ValueHandler.state == false then -- false state for ValueHandlers.KeyState is nil
        self.ValueHandler:Remove(childUIObject)
    else
        self.ValueHandler:Insert(childUIObject)
    end

    self:Arrange()
end