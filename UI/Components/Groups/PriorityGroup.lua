TheEyeAddon.UI.Components.PriorityGroup = {}
local this = TheEyeAddon.UI.Components.PriorityGroup
local inherited = TheEyeAddon.UI.Components.IconGroup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    
    inherited.Setup(
        instance
    )

    local icons = instance.Icons    
    for i = 1, #icons do
        local icon = icons[i]
        local validKeys = table.copy(icon.PriorityRank.validKeys)
        local listeners = table.copy(icon.PriorityRank.listeners)

        icon.UIObject.PriorityRank =
        {
            ValueHandler =
            {
                validKeys = validKeys,
            },
        }

        if listeners ~= nil then
            icon.UIObject.PriorityRank.ListenerGroup =
            {
                Listeners = listeners,
            }
        end
    end
end