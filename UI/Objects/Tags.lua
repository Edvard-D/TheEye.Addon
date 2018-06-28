local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Tags = {}

local ipairs = ipairs
local table = table
local tagGroups = {}


local function KeyHasTags(key, tags)
    for i,tag in ipairs(tags) do
        if key:find(tag) == nil then
            return false
        end
    end

    return true
end


function TheEyeAddon.UI.Objects.Tags:UIObjectHasTags(uiObject, tags, tagsConcatenated)
    if tagGroups[tagsConcatenated] ~= nil then
        if tagGroups[tagsConcatenated][uiObject.key] == true then
            return true
        else
            return false
        end
    else
        tagGroups[tagsConcatenated] = {}
    end
    
    tagGroups[tagsConcatenated][uiObject.key] = KeyHasTags(uiObject.key, tags)
end