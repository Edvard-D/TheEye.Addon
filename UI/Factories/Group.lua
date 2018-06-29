local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}

local Pool = TheEyeAddon.UI.Pools:Create()
local unpack = unpack


local function GetBoundsFromRects(rects)
	local leftMin, bottomMin, width, height = unpack(childRects[1])
	local rightMax = width + leftMin
	local topMax = height + bottomMin
	
	if #childRects > 1 then
		for i = 2, #childRects do
			local left, bottom, width, height = unpack(childRects[i])

			leftMin = left < leftMin or leftMin
			bottomMin = bottom < bottomMin or bottomMin
			rightMax = width + left > rightMax or rightMax
			topMax = height + bottom > topMax or topMax
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
    local children = self.uiObject.Children
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

            table.insert(childRects, { childFrame:GetRect() })
            
            xOffset, yOffset = self.GroupArranger.UpdateOffset(xOffset, yOffset, childFrame)
        end
	end
	
	self:SetSizeWithEvent(GetSizeFromRects(childRects))
end


function TheEyeAddon.UI.Factories.Group:Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", displayData.parentKey, nil, displayData.DimensionTemplate)
	
	instance.GroupArranger = displayData.GroupArranger
	instance.ChildrenArrange = TheEyeAddon.UI.Factories.Group.ChildrenArrange

	return instance
end