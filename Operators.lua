local TheEyeAddon = TheEyeAddon
TheEyeAddon.Operators = {}


function TheEyeAddon.Operators.EqualTo(value1, value2)
    if value1 == value2 then
        return true
    else
        return false
    end
end