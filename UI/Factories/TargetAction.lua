TheEyeAddon.UI.Factories.TargetAction = {}
local this = TheEyeAddon.UI.Factories.TargetAction

local backgroundColor = { 0.1, 0.1, 0.1, 1 }
local castImmuneColor = { 0.5, 0.5, 0.5, 1 }
local castInterruptableColor = { 0.8, 0.46, 0.19, 1 }
local EventRegister = TheEyeAddon.Managers.Events.Register
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local select = select
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create
local tostring = tostring
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local unpack = unpack


function this.Claim(uiObject, parentFrame, dimensions, unit, dotSpellIDs)
    local instance = FrameClaim(uiObject, "TargetAction", parentFrame, nil, dimensions)
    instance.unit = unit

    instance.CastSet = this.CastSet
    instance.InterruptSet = this.InterruptSet
	instance.customEvents = { "UPDATE", }
    EventRegister(instance)
    instance.OnEvent = this.OnEvent
    
    instance.CastIcon = instance.CastIcon or TextureCreate(instance, "ARTWORK")
    instance.CastIcon:SetSize(dimensions.height, dimensions.height)
    instance.CastIcon:SetPoint("LEFT", instance, "LEFT")

    local barWidth = dimensions.width - dimensions.height
    instance.Background = instance.Background or {}
    instance.Background.Base = instance.Background.Base or TextureCreate(instance, "BACKGROUND", "BLEND")
    instance.Background.Base:SetSize(barWidth - (dimensions.height / 2), dimensions.height)
    instance.Background.Base:SetPoint("LEFT", instance.CastIcon, "RIGHT")
    instance.Background.Base:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/TargetAction_Cast_Base.blp")
    instance.Background.Base:SetVertexColor(unpack(backgroundColor))

    instance.Background.End = instance.Background.End or TextureCreate(instance, "BACKGROUND", "BLEND")
    instance.Background.End:SetSize(dimensions.height / 2, dimensions.height)
    instance.Background.End:SetPoint("LEFT", instance.Background.Base, "RIGHT")
    instance.Background.End:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/TargetAction_Cast_End.blp")
    instance.Background.End:SetVertexColor(unpack(backgroundColor))

    instance.Bar = instance.Bar or {}
    instance.Bar.maxWidth = barWidth - (dimensions.height / 2)
    instance.Bar.height = dimensions.height
    instance.Bar.Base = instance.Bar.Base or TextureCreate(instance, "ARTWORK", "BLEND")
    instance.Bar.Base:SetSize(instance.Bar.maxWidth, dimensions.height)
    instance.Bar.Base:SetPoint("LEFT", instance.CastIcon, "RIGHT")
    instance.Bar.Base:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/TargetAction_Cast_Base.blp")

    instance.Bar.End = instance.Bar.End or TextureCreate(instance, "ARTWORK", "BLEND")
    instance.Bar.End:SetSize(dimensions.height / 2, dimensions.height)
    instance.Bar.End:SetPoint("LEFT", instance.Bar.Base, "RIGHT")
    instance.Bar.End:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/TargetAction_Cast_End.blp")

    instance.InterruptIcon = instance.InterruptIcon or TextureCreate(instance, "OVERLAY")
    instance.InterruptIcon:SetSize(dimensions.height * 1.5, dimensions.height * 1.5)
    instance.InterruptIcon:SetPoint("CENTER", instance.Bar.End, "CENTER")

    instance.Name = instance.Name or FontStringCreate(instance)
    instance.Name:StyleSet("ARTWORK", TheEyeAddon.Values.FontTemplates.TargetAction.CastName)
    instance.Name:SetPoint("LEFT", instance.CastIcon, "RIGHT", dimensions.height * 0.2, 0)

    return instance
end

function this:CastSet(spellID)
    local notInterruptible, spellID = select(8, UnitCastingInfo(self.unit))
    if spellID == nil then
        notInterruptible, spellID = select(7, UnitChannelInfo(self.unit))
    end
    local name, _, fileID = GetSpellInfo(spellID)

    self.Name:SetText(name)
    self.CastIcon:SetTexture(fileID)

    if notInterruptible == true then
        self.Bar.Base:SetVertexColor(unpack(castImmuneColor))
        self.Bar.End:SetVertexColor(unpack(castImmuneColor))
    else
        self.Bar.Base:SetVertexColor(unpack(castInterruptableColor))
        self.Bar.End:SetVertexColor(unpack(castInterruptableColor))

        if self.interruptSpellID ~= nil then
            self:InterruptSet(true, self.interruptSpellID)
        end
    end
end

function this:InterruptSet(isVisible, spellID)
    local notInterruptible = select(8, UnitCastingInfo(self.unit))
    if notInterruptible == nil then
        notInterruptible = select(7, UnitChannelInfo(self.unit))
    end

    if isVisible == true and notInterruptible == false then
        local fileID = select(3, GetSpellInfo(spellID))

        self.interruptSpellID = spellID
        self.InterruptIcon:SetTexture(fileID)
        self.InterruptIcon:Show()
    else
        self.interruptSpellID = nil
        self.InterruptIcon:Hide()
    end
end

function this:OnEvent(event)
    local startTime, endTime = select(4, UnitCastingInfo(self.unit))
    local isChanneling = false
    if startTime == nil then
        startTime, endTime = select(4, UnitChannelInfo(self.unit))
        isChanneling = true
    end

    if startTime == nil then
        self:Hide()
    else
        local castLength = (endTime - startTime) / 1000
        local elapsedTime = GetTime() - (startTime / 1000)

        if isChanneling == false then
            self.Bar.Base:SetSize(self.Bar.maxWidth * (elapsedTime / castLength), self.Bar.height)
        else
            self.Bar.Base:SetSize(self.Bar.maxWidth * (1 - (elapsedTime / castLength)), self.Bar.height)
        end

        self:Show()
    end
end