local TEA = TheEyeAddon
TEA.TypeHelpers = {}

local setmetatable = setmetatable


function TEA.TypeHelpers:Protect(table)
	return setmetatable ({}, {
		self:__index = tbl
		self:__newindex = function (t, key, value)
			error("Cannot change " .. tostring(table) ..  " value " .. tostring(key) .. " to " .. tostring(value)".", 2)
		end
	})
end