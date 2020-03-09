TheEye.Core.Tags = {}
local this = TheEye.Core.Tags

local tagGroups = {}


local function GetTagGroup(tagKey)
    if tagGroups[tagKey] == nil then
        tagGroups[tagKey] = {}
    end
    
    return tagGroups[tagKey]
end

function this.UIObjectHasTag(uiObject, tag)
    local tagGroup = GetTagGroup(tag)
    local uiObjectKey = uiObject.key

    if tagGroup[uiObjectKey] == nil then
        tagGroup[uiObjectKey] = uiObjectKey:find(tag) ~= nil
    end

    return tagGroup[uiObjectKey]
end

local function KeyHasTags(key, tags)
    for i = 1, #tags do
        if key:find(tags[i]) == nil then
            return false
        end
    end
    return true
end

function this.UIObjectHasTags(uiObject, tags, tagKey)
    local tagGroup = GetTagGroup(tagKey)
    local uiObjectKey = uiObject.key

    if tagGroup[uiObjectKey] == nil then
        tagGroup[uiObjectKey] = KeyHasTags(uiObjectKey, tags)
    end

    return tagGroup[uiObjectKey]
end