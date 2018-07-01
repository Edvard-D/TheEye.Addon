local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.EnabledVisibleManager = {}
local this = TheEyeAddon.UI.Components.EnabledVisibleManager


-- DEFINED IN TEMPLATE
--      Enabled             Enabled: must be of type KeyBasedStateManager
--      Visible             Visible: must be of type KeyBasedStateManager


-- SETUP
--      instance
--      UIObject            UIObject
function this:Setup(
    instance,
    UIObject
)

    instance.UIObject = UIObject

    TheEyeAddon.UI.Components.KeyBasedStateManager:Setup(
        instance.Enabled,
        this.Enable,
        this.Disable
    )

    TheEyeAddon.UI.Components.KeyBasedStateManager:Setup(
        instance.Visible,
        this.Show,
        this.Hide
    )
end

function this:Enable(uiObject)
    print ("ENABLE    " .. uiObject.key) -- DEBUG
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, "EVENT")
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
end

function this:Disable(uiObject)
    print ("DISABLE    " .. uiObject.key) -- DEBUG
    TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroup(uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroupsOfType(uiObject, "EVENT")
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", uiObject)
end

function this:Show(uiObject)
    print ("SHOW    " .. uiObject.key) -- DEBUG
    uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject, uiObject.DisplayData)
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
end

function this:Hide(uiObject)
    print ("HIDE    " .. uiObject.key) -- DEBUG
    TheEyeAddon.UI.Pools:Release(uiObject.frame)
    uiObject.frame = nil
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_HIDDEN", uiObject)
end