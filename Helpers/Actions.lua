TheEyeAddon.Managers.Actions = {}
local this = TheEyeAddon.Managers.Actions


local table = table
this.values = {}


function this.Add(action)
    table.insert(this.values, action)
end
