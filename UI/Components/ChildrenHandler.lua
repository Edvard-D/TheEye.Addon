local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ChildrenHandler = {}
local this = TheEyeAddon.UI.Components.ChildrenHandler

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateReactor.Setup
local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Objects.Components.ListenerGroups.NotifyBasedFunctionCaller.Setup
local SortedTableSetup = TheEyeAddon.UI.Objects.Components.ValueHandlers.SortedTable.Setup


--[[ #this#TEMPLATE#
{
    childTags = { #ARRAY#TAG# }
    GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers#NAME#
    sortActionName = #SORTACTION#NAME#
    sortValueComponentName = #COMPONENT#NAME#
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
]]
function this:Setup(
    instance,
    UIObject
)

    instance.UIObject = UIObject
    instance.Arrange = this.Arrange

    -- ValueHandler
    instance.ValueHandler = {}
    SortedTableSetup:Setup(
        instance.ValueHandler,
        UIObject,
        instance.sortActionName,
        instance.sortValueComponentName
    )

    -- ListenerGroups
    instance.ListenerGroups =
    {
        Arrange =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags }
                },
                {
                    eventName = "UIOBJECT_WITHTAGS_SORTRANK_CHANGED",
                    inputValues = { instance.childTags }
                }
            }
        },
        Sort =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags }
                }
            }
        },
        UpdateRegisteredChildren =
        {
            Listeners =
            {
                {
                    eventName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED",
                    inputValues = { instance.childTags },
                }
            }
        }
    }

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Arrange,
        UIObject,
        this.Arrange -- @TODO
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.Sort,
        UIObject,
        instance.ValueHandler.Sort
    )

    NotifyBasedFunctionCallerSetup(
        instance.ListenerGroups.UpdateRegisteredChildren,
        UIObject,
        this.UpdateRegisteredChildren -- @TODO
    )

    -- EnabledStateReactor
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        UIObject,
        instance.OnEnable, -- @TODO
        instance.OnDisable -- @TODO
    )
end