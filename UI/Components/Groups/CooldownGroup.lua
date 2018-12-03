TheEyeAddon.UI.Components.CooldownGroup = {}
local this = TheEyeAddon.UI.Components.CooldownGroup
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
        local OBJECT_ID = GetPropertiesOfType(icon, "OBJECT_ID")

        icon.UIObject.Cooldown =
        {
            spellID = OBJECT_ID.value,
        }
    end
end