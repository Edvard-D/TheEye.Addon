TheEyeAddon.UI.Factories.CastBar = {}
local this = TheEyeAddon.UI.Factories.CastBar

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


function this.Claim(uiObject, parentFrame, dimensions, unit, colors, showIcon, showSecondaryIcon, showName, fontTemplate)
    local instance = FrameClaim(uiObject, "CastBar", parentFrame, nil, dimensions)

    instance.unit = unit
    instance.colors = colors -- { background, immune, interruptable }
    instance.showIcon = showIcon
    instance.showSecondaryIcon = showSecondaryIcon
    instance.showName = showName

    instance.CastSet = this.CastSet
    instance.SecondaryIconAdd = this.SecondaryIconAdd
    instance.SecondaryIconRemove = this.SecondaryIconRemove
    instance.secondaryIcons = {}
	instance.customEvents = { "UPDATE", }
    EventRegister(instance)
    instance.OnEvent = this.OnEvent
    
    local barWidth = dimensions.width
    
    if showIcon == true then
        barWidth = barWidth - dimensions.height
    end

    instance.CastIcon = instance.CastIcon or TextureCreate(instance, "ARTWORK")
    instance.CastIcon:SetSize(dimensions.height, dimensions.height)
    instance.CastIcon:SetPoint("LEFT", instance, "LEFT")
    if showIcon == true then
        instance.CastIcon:Show()
    else
        instance.CastIcon:Hide()
    end

    instance.Background = instance.Background or {}
    instance.Background.Base = instance.Background.Base or TextureCreate(instance, "BACKGROUND", "BLEND")
    instance.Background.Base:SetSize(barWidth - (dimensions.height / 2), dimensions.height)
    instance.Background.Base:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/CastBar_Base.blp")
    instance.Background.Base:SetVertexColor(unpack(colors.background))

    instance.Background.End = instance.Background.End or TextureCreate(instance, "BACKGROUND", "BLEND")
    instance.Background.End:SetSize(dimensions.height / 2, dimensions.height)
    instance.Background.End:SetPoint("LEFT", instance.Background.Base, "RIGHT")
    instance.Background.End:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/CastBar_End.blp")
    instance.Background.End:SetVertexColor(unpack(colors.background))

    instance.Bar = instance.Bar or {}
    instance.Bar.maxWidth = barWidth - (dimensions.height / 2)
    instance.Bar.height = dimensions.height
    instance.Bar.Base = instance.Bar.Base or TextureCreate(instance, "ARTWORK", "BLEND")
    instance.Bar.Base:SetSize(instance.Bar.maxWidth, dimensions.height)
    instance.Bar.Base:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/CastBar_Base.blp")

    instance.Bar.End = instance.Bar.End or TextureCreate(instance, "ARTWORK", "BLEND")
    instance.Bar.End:SetSize(dimensions.height / 2, dimensions.height)
    instance.Bar.End:SetPoint("LEFT", instance.Bar.Base, "RIGHT")
    instance.Bar.End:SetTexture("Interface/AddOns/TheEyeAddon/UI/Textures/CastBar_End.blp")

    if showIcon == true then
        instance.Background.Base:ClearAllPoints()
        instance.Background.Base:SetPoint("LEFT", instance.CastIcon, "RIGHT")
        instance.Bar.Base:ClearAllPoints()
        instance.Bar.Base:SetPoint("LEFT", instance.CastIcon, "RIGHT")
    else
        instance.Background.Base:ClearAllPoints()
        instance.Background.Base:SetPoint("LEFT", instance, "LEFT")
        instance.Bar.Base:ClearAllPoints()
        instance.Bar.Base:SetPoint("LEFT", instance, "LEFT")
    end

    instance.SecondaryIcon = instance.SecondaryIcon or TextureCreate(instance, "OVERLAY")
    instance.SecondaryIcon:SetSize(dimensions.height * 1.5, dimensions.height * 1.5)
    instance.SecondaryIcon:SetPoint("CENTER", instance.Bar.End, "CENTER")
    if showSecondaryIcon == true then
        instance.SecondaryIcon:Show()
    else
        instance.SecondaryIcon:Hide()
    end

    instance.Name = instance.Name or FontStringCreate(instance)
    instance.Name:StyleSet("ARTWORK", fontTemplate)
    instance.Name:SetPoint("LEFT", instance.CastIcon, "RIGHT", dimensions.height * 0.2, 0)
    if showName == true then
        instance.Name:Show()
    else
        instance.Name:Hide()
    end

    return instance
end

function this:CastSet(spellID)
    local notInterruptible, spellID = select(8, UnitCastingInfo(self.unit))
    if spellID == nil then
        notInterruptible, spellID = select(7, UnitChannelInfo(self.unit))
    end
    local name, _, fileID = GetSpellInfo(spellID)

    if self.showName == true then
        self.Name:SetText(name)
    end
    if self.showIcon == true then
        self.CastIcon:SetTexture(fileID)
    end

    if notInterruptible == true then
        self.Bar.Base:SetVertexColor(unpack(self.colors.immune))
        self.Bar.End:SetVertexColor(unpack(self.colors.immune))

        self.SecondaryIcon:Hide()
    else
        self.Bar.Base:SetVertexColor(unpack(self.colors.interruptable))
        self.Bar.End:SetVertexColor(unpack(self.colors.interruptable))

        if self.showSecondaryIcon == true and #self.secondaryIcons > 0 then
            local fileID = select(3, GetSpellInfo(self.secondaryIcons[1]))
            self.SecondaryIcon:SetTexture(fileID)
            self.SecondaryIcon:Show()
        else
            self.SecondaryIcon:Hide()
        end
    end
end

function this:SecondaryIconAdd(spellID)
    if table.hasvalue(self.secondaryIcons, spellID) == false then
        table.insert(self.secondaryIcons, spellID)
    end
end

function this:SecondaryIconRemove(spellID)
    table.removevalue(self.secondaryIcons, spellID)
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