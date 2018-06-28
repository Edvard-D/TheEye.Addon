local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Tags = {}

local ipairs = ipairs


local function KeyHasTags(key, tags)
    for i,tag in ipairs(tags) do
        if key:find(tag) == nil then
            return false
        end
    end

    return true
end