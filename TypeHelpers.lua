local TheEyeAddon = TheEyeAddon
TheEyeAddon.TypeHelpers = {}

local setmetatable = setmetatable


function TheEyeAddon.TypeHelpers:Protect(tbl)
	return setmetatable({}, {
     __index = tbl,
     __newindex = function(table, key, value)
                    error("Cannot change " ..
                    tostring(tbl) ..
                    " value " ..
                    tostring(key) ..
                    " to " ..
                    tostring(value) ..
                    ".", 2)
                  end,
     __metatable = false
   })
end