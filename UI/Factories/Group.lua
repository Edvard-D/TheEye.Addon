local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()
local unpack = unpack


local function GetBoundsFromRects(rects)
	local leftMin, bottomMin, width, height = unpack(rects[1])
	local rightMax = width + leftMin
	local topMax = height + bottomMin

	if #rects > 1 then
		for i = 2, #rects do
			local left, bottom, width, height = unpack(rects[i])

			if left < leftMin then leftMin = left end
			if bottom < bottomMin then bottomMin = bottom end
			if width + left > rightMax then rightMax = width + left end
			if height + bottom > topMax then topMax = height + bottom end
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
    local xOffset = 0
    local yOffset = 0
    local childRects = {}

    for i = 1, #children do
        local childFrame = children[i].frame
        if childFrame ~= nil then
            local xOffsetCurrent, yOffsetCurrent = select(4, childFrame:GetPoint(1))
            
            if xOffsetCurrent ~= xOffset or yOffsetCurrent ~= yOffset then
                childFrame:ClearAllPoints()
                childFrame:SetPoint(self.GroupArranger.point, self, self.GroupArranger.relativePoint, xOffset, yOffset)
            end

			local childRect = { childFrame:GetRect() }
			if #childRect > 0 then
				table.insert(childRects, { childFrame:GetRect() })
			end
            
            xOffset, yOffset = self.GroupArranger.UpdateOffset(xOffset, yOffset, childFrame)
        end
	end
	
	if #childRects > 0 then
		self:SetSizeWithEvent(GetSizeFromRects(childRects))
	end
end


function TheEyeAddon.UI.Factories.Group:Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", displayData.parentKey, nil, displayData.DimensionTemplate)
	
	instance.GroupArranger = displayData.GroupArranger
	instance.ChildrenArrange = TheEyeAddon.UI.Factories.Group.ChildrenArrange

	return instance
end