TheEye.Core.UI.Components.Frame = {}
local this = TheEye.Core.UI.Components.Frame
local inherited = TheEye.Core.UI.Elements.Base

local FrameClaim = TheEye.Core.Managers.FramePools.FrameClaim
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local SendCustomEvent = TheEye.Core.Managers.Events.SendCustomEvent
local VisibleStateFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    #OPTIONAL#Dimensions =
    {
        #OPTIONAL#PointSettings =
        {
            #OPTIONAL#point = #POINT#
            #OPTIONAL#relativePoint = #RELATIVEPOINT#
            #OPTIONAL#offsetX = #NUMBER#
            #OPTIONAL#offsetY = #NUMBER#
        }
        #OPTIONAL#width = #NUMBER#
        #OPTIONAL#height = #NUMBER#
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

    instance.Deactivate = this.Deactivate
    instance.ModifierAdd = this.ModifierAdd
    instance.ModifierRemove = this.ModifierRemove

    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        instance,
        1
    )
end


function this:Deactivate()
    self.VisibleStateFunctionCaller:Deactivate()
end

function this:OnShow()
    self.state = true
    self.instance = FrameClaim(self.UIObject, "Frame", nil, nil, self.Dimensions)
    
    if self.modifiers ~= nil then
        local modifiers = self.modifiers
        for k,category in pairs(modifiers) do
            if category.creator ~= nil then
                category.creator:Modify(self.instance)
                
                local changers = category.changers
                if changers ~= nil then
                    for i = 1, #changers do
                        changers[i]:Modify(self.instance)
                    end
                end
            end
        end
    end

    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end

function this:OnHide()
    if self.modifiers ~= nil then
        local modifiers = self.modifiers
        for k,category in pairs(modifiers) do
            if category.creator ~= nil then
                local changers = category.changers
                if changers ~= nil then
                    for i = 1, #changers do
                        changers[i]:Demodify(self.instance)
                    end
                end
                
                category.creator:Demodify(self.instance)
            end
        end
    end
    
    self.state = false
    self.instance:Release()
    self.instance = nil
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end


-- Modifiers
local function ModifierCategoryGet(modifiers, categoryKey)
    if modifiers[categoryKey] == nil then
        modifiers[categoryKey] = {}
    end

    return modifiers[categoryKey]
end

function this:ModifierAdd(modifier)
    if self.modifiers == nil then
        self.modifiers = {}
    end
    local category = ModifierCategoryGet(self.modifiers, modifier.categoryKey)

    if modifier.roleKey == "creator" then
        category.creator = modifier
    else
        if category.changers == nil then
            category.changers = {}
        end
        table.insert(category.changers, modifier)
    end

    if self.instance ~= nil then
        modifier:Modify(self.instance)

        local changers = category.changers
        if modifier.roleKey == "creator" and changers ~= nil then
            for i = 1, #changers do
                changers[i]:Modify(self.instance)
            end
        end
    end
end

function this:ModifierRemove(modifier)
    if self.modifiers == nil then
        return
    end

    local category = ModifierCategoryGet(self.modifiers, modifier.categoryKey)

    if modifier.roleKey == "creator" then
        category.creator = nil
    else
        table.removevalue(category.changers, modifier)
    end

    if self.instance ~= nil then
        local changers = category.changers
        if modifier.roleKey == "creator" and changers ~= nil then
            for i = 1, #changers do
                changers[i]:Demodify(self.instance)
            end
        end

        modifier:Demodify(self.instance)
    end
end