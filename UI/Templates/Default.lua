local EnabledStateSetup = TheEyeAddon.UI.Components.EnabledState.Setup


table.insert(TheEyeAddon.UI.Templates, 
{
    tags = {},
    Setup = function(UIObject)
        UIObject.EnabledState = UIObject.EnabledState or {}
        EnabledStateSetup(
            UIObject.EnabledState,
            UIObject
        )
    end
})