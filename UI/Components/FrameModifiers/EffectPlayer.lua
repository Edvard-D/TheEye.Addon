TheEye.Core.UI.Components.EffectPlayer = {}
local this = TheEye.Core.UI.Components.EffectPlayer
local inherited = TheEye.Core.UI.Components.FrameModifierBase

local EventsDeregister = TheEye.Core.Managers.Events.Deregister
local EventsRegister = TheEye.Core.Managers.Events.Register
local GetTime = GetTime
local ModelClaim = TheEye.Core.UI.Factories.Model.Claim
local NotifyBasedFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local soundFadeOutDuration = 1000 -- milliseconds
local StopSound = StopSound


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    Elements = { #EFFECT#SETTINGS# }
    triggerType = #TRIGGER#TYPE#
    triggerSpellID = #OPTIONAL#SPELL#ID#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    
    for i = 1, #instance.Elements do
        if instance.Elements[i].duration == nil or instance.Elements[i].duration == 0 then
            instance.Elements[i].duration = math.huge
        end
    end

    instance.Modify = this.Modify
    instance.Demodify = this.Demodify
    instance.OnEvent = this.OnEvent
    instance.OnNotify = this.OnNotify

    instance.customEvents = { "UPDATE", }

    if instance.triggerType == "STACK_COUNT" then
        instance.StackCountListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_AURA_STACK_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] instance.triggerSpellID, },
                },
            },
        }

        NotifyBasedFunctionCallerSetup(
            instance.StackCountListenerGroup,
            instance,
            "OnNotify"
        )
    end

    inherited.Setup(
        instance,
        "effectPlayer",
        "creator"
    )
end

function this:Modify(frame)
    self.startTime = GetTime()

    for i = #self.Elements, 1, -1 do
        local element = self.Elements[i]

        if element.type == "VISUAL" then
            local dimensions =
            {
                size = element.size,
                scale = element.scale,
                rotation = element.rotation,
                PointSettings =
                {
                    point = "CENTER",
                    relativePoint = "CENTER",
                },
            }
            element.frame = ModelClaim(nil, frame, dimensions, element.fileID)
            element.frame:Hide()

            element.isActive = false
        end

        element.isInitialized = false
    end

    EventsRegister(self)

    if self.triggerType == "STACK_COUNT" then
        self.StackCountListenerGroup:Activate()
    elseif self.triggerType == nil then
        self:OnNotify()
    end
end

function this:Demodify(frame)
    for i = 1, #self.Elements do
        local element = self.Elements[i]

        if element.type == "VISUAL" and element.frame ~= nil then
            element.frame:Release()
            element.frame = nil
            element.isActive = false
        elseif element.type == "SOUND" and element.soundHandle ~= nil then
            StopSound(element.soundHandle, soundFadeOutDuration)
            element.soundHandle = nil
        end

        element.isInitialized = false
    end

    EventsDeregister(self)

    if self.triggerType == "STACK_COUNT" then
        self.StackCountListenerGroup:Deactivate()
    end
end

local function VisualManage(self, element, elapsedPoint)
    if self.triggerType ~= nil
        and element.duration ~= math.huge
        and elapsedPoint >= element.startPoint + element.duration
        and element.isActive == true
        and element.isInitialized == true
        then
        element.isPendingHide = true
        element.pendedTime = GetTime()
        element.isActive = false
    elseif element.frame ~= nil
        and (self.triggerType == nil or elapsedPoint >= element.startPoint)
        and element.isInitialized ~= true
        then
        element.isPendingShow = true
        element.pendedTime = GetTime()
        element.frame:ModelShowAndSet(element.fileID)
        element.frame:SetSize(0.0001, 0.0001)
        element.isInitialized = true
        element.isActive = true
    end
end

local function SoundManage(self, element, elapsedPoint)
    if elapsedPoint >= element.startPoint and element.isInitialized ~= true then
        element.soundHandle = select(2, PlaySound(tonumber(element.id), "Master", false))
        element.isInitialized = true
    end
end

local function ElementsManage(self, elapsedPoint)
    for i = 1, #self.Elements do
        local element = self.Elements[i]

        if element.type == "VISUAL" then
            VisualManage(self, element, elapsedPoint)
        elseif element.type == "SOUND" then
            SoundManage(self, element, elapsedPoint)
        end
    end
end

--[[ Pending is necessary to account for visual effects that have a one frame visual glitch when they're
    displayed. Pending newly hidden effects by one frame as well ensures there are no lapses in visuals
    being displayed in cases where a newly activated visual is meant to replace a newly deactivated
    visual.]]
local function PendingElementsManage(self)
    for i = 1, #self.Elements do
        local element = self.Elements[i]

        if element.pendedTime ~= GetTime() then
            if element.isPendingShow == true then
                element.isPendingShow = false
                element.frame:SetSize(element.size, element.size)
                element.frame:Redraw()
            elseif element.isPendingHide == true then
                element.isPendingHide = false
                element.frame:Release()
                element.frame = nil
            end
        end
    end
end

function this:OnEvent(event)
    PendingElementsManage(self)

    if self.triggerType == "ELAPSED_TIME" then
        local elapsedTime = GetTime() - self.startTime
        ElementsManage(self, elapsedTime)
    end
end

function this:OnNotify(event, elapsedStack)
    ElementsManage(self, elapsedStack)
end