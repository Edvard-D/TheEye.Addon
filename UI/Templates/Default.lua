local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Templates.Default = {}
local this = TheEyeAddon.UI.Templates.Default

this.tags = {}

local EnabledStateSetup = TheEyeAddon.UI.Components.EnabledState.Setup


function this:Setup(UIObject)
    UIObject.EnabledState = {}
    EnabledStateSetup(
        UIObject.EnabledState,
        UIObject
    )
end