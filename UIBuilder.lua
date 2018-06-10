local TEA = TheEyeAddon
TEA.UIBuilder = {}

local setmetatable = setmetatable
local UIParent = UIParent


function TEA.UIBuilder:Create()
	local instance = {}


	setmetatable(instance, TEA.UIBuilder)
	self.__index = self

	return instance
end

function TEA.UIBuilder:Initialize()
	local mindFlayID = 15407
	TEA.UIObjects.Icon:Create(UIParent, TEA.UIObjects.IconObjectType.Spell, mindFlayID, false, nil, false, false)
end