local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()
local unpack = unpack


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

function TheEyeAddon.UI.Factories.Group:ChildrenArrange(children)
    local children = self.UIObject.Children
    local combinedOffsetX = 0
    local combinedOffsetY = 0
    local childRects = {}

    for i = 1, #children do
        local childFrame = children[i].frame
        if childFrame ~= nil then
            local currentOffsetX, currentOffsetY = select(4, childFrame:GetPoint(1))
            
            if currentOffsetX ~= combinedOffsetX or currentOffsetY ~= combinedOffsetY then
                childFrame:ClearAllPoints()
                childFrame:SetPoint(self.GroupArranger.point, self, self.GroupArranger.relativePoint, combinedOffsetX, combinedOffsetY)
            end

			table.insert(childRects, { childFrame:GetRect() })
            combinedOffsetX, combinedOffsetY = self.GroupArranger.UpdateOffset(combinedOffsetX, combinedOffsetY, childFrame)
        end
	end
	
	if #childRects > 0 then
		self:SetSizeWithEvent(GetSizeFromRects(childRects))
	else
		self:SetSizeWithEvent(0, 0)
	end
end


function TheEyeAddon.UI.Factories.Group:Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", displayData.parentKey, nil, displayData.DimensionTemplate)
	
	instance.GroupArranger = displayData.GroupArranger
	instance.ChildrenArrange = TheEyeAddon.UI.Factories.Group.ChildrenArrange

	return instance
end