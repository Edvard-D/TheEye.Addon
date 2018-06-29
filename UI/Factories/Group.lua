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


function TheEyeAddon.UI.Factories.Group:Claim(uiObject, displayData)
	local instance = Pool:Claim(uiObject, "Frame", displayData.parentKey, nil, displayData.DimensionTemplate)
	
	instance.GroupArranger = displayData.GroupArranger
	instance.ChildrenArrange = TheEyeAddon.UI.Factories.Group.ChildrenArrange

	return instance
end