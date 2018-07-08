local ChildrenSetup = TheEyeAddon.UI.Components.Children.Setup


table.insert(TheEyeAddon.UI.Templates, 
{
    tags = { "GROUP" },
    Setup = function(UIObject)
        UIObject.Children = UIObject.Children or {}
        ChildrenSetup(
            UIObject.Children,
            UIObject
        )
    end
})