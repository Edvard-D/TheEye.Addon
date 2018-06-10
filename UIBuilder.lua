local TEA = TheEyeAddon
TEA.UIBuilder = {}

local setmetatable = setmetatable
local UIParent = UIParent


function TEA.UIBuilder:Create(instance)
	local instance = instance or {}


	setmetatable(instance, TEA.UIBuilder)
	self.__index = self

	return instance
end

function TEA.UIBuilder:Initialize()
	local mindFlayID = 15407
	TEA.UIObjects.Icon:Create(nil, UIParent, TEA.UIObjects.IconObjectType.Spell, mindFlayID, false, nil, false, false)
end