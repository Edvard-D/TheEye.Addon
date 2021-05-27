TheEye.Core.UI.Components.ActionBarCombatHider = {}
local this = TheEye.Core.UI.Components.ActionBarCombatHider
local inherited = TheEye.Core.UI.Elements.Base


local EventsDeregister = TheEye.Core.Managers.Events.Deregister
local EventsRegister = TheEye.Core.Managers.Events.Register
local VisibleStateFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


function this.Setup(
    instance
)

    inherited.Setup(
        instance
    )

    if _G["TheEyeCharacterSettings"].UI.ShouldHideActionBarDuringCombat == false then
        return
    end
    
    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        instance,
        1
    )
    
    --instance.OnEvent = this.OnEvent
    --instance.customEvents = { "UPDATE", }
end

local function ButtonsDisplayChange(buttonType, action)
    for i = 1, 12 do
        local frameName = buttonType .. i

        if _G[frameName] ~= nil then
            _G[frameName][action](_G[frameName])
        end
    end
end

function this:OnShow()
    this.FramesHide()
    --EventsRegister(self)
end

function this:OnHide()
    this.FramesShow()
    --EventsDeregister(self)
end

function this:OnEvent(event)
    this.FramesHide()
end

function this.FramesShow()
    StanceBarFrame:Show()
    ActionBarUpButton:Show()
    ActionBarDownButton:Show()
    MainMenuBarArtFrameBackground:Show()
    MainMenuBarArtFrame.PageNumber:Show()
    MainMenuBarArtFrame.LeftEndCap:Show()
    MainMenuBarArtFrame.RightEndCap:Show()
    ButtonsDisplayChange("ActionButton", "Show")
    ButtonsDisplayChange("MultiBarBottomLeftButton", "Show")
    ButtonsDisplayChange("MultiBarBottomRightButton", "Show")
end

function this.FramesHide()
    StanceBarFrame:Hide()
    ActionBarUpButton:Hide()
    ActionBarDownButton:Hide()
    MainMenuBarArtFrameBackground:Hide()
    MainMenuBarArtFrame.PageNumber:Hide()
    MainMenuBarArtFrame.LeftEndCap:Hide()
    MainMenuBarArtFrame.RightEndCap:Hide()
    ButtonsDisplayChange("ActionButton", "Hide")
    ButtonsDisplayChange("MultiBarBottomLeftButton", "Hide")
    ButtonsDisplayChange("MultiBarBottomRightButton", "Hide")
end