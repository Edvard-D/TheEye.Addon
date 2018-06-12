local TheEyeAddon = TheEyeAddon
TheEyeAddon.TypeHelpers = {}

local setmetatable = setmetatable


function TheEyeAddon.TypeHelpers:Protect(table)
	return setmetatable({}, {
     __index = table,
     __newindex = function(table, key, value)
                    error("Cannot change " ..
                    tostring(table) ..
                    " value " ..
                    tostring(key) ..
                    " to " ..
                    tostring(value) ..
                    ".", 2)
                  end,
     __metatable = false
   })
end