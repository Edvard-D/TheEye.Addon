TheEyeAddon.UI.Factories.TargetFrame = {}
local this = TheEyeAddon.UI.Factories.TargetFrame

local dotPadding = 5
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim
local GetSpellInfo = GetSpellInfo
local math = math
local midRotationRate = -0.01
local overlayRotationRate = -0.005
local select = select
local TextureCreate = TheEyeAddon.UI.Factories.Texture.Create
local tostring = tostring
local UnitName = UnitName
local unpack = unpack


function this.Claim(uiObject, parentFrame, dimensions, unit, dotSpellIDs)
    local instance = FrameClaim(uiObject, "TargetFrame", parentFrame, nil, dimensions)
    local spec = GetSpecializationInfo(GetSpecialization())
    local colors = TheEyeAddon.Values.Colors[spec].TargetFrame
    instance.unit = unit

    instance.Background = instance.Background or TextureCreate(instance, "BACKGROUND", "BLEND")
    instance.Background:TextureSet("Interface/AddOns/TheEyeAddon/UI/Textures/TargetFrame_Background.blp")
    instance.Background:SetVertexColor(unpack(colors.background))

    instance.Swirl = instance.Swirl or TextureCreate(instance, "BORDER", "BLEND")
    instance.Swirl:TextureSet("Interface/AddOns/TheEyeAddon/UI/Textures/TargetFrame_Mid.blp")
    instance.Swirl:SetVertexColor(unpack(colors.mid))
    instance.Swirl:RotationStart(midRotationRate)
    
    instance.Overlay = instance.Overlay or TextureCreate(instance, "BORDER", "BLEND")
    instance.Overlay:TextureSet("Interface/AddOns/TheEyeAddon/UI/Textures/TargetFrame_Overlay.blp")
    instance.Overlay:SetVertexColor(unpack(colors.overlay))
    instance.Overlay:RotationStart(overlayRotationRate)

    --[[instance.PlayerCast = instance.PlayerCast or CreateFrame("Cooldown", nil, instance, "CooldownFrameTemplate")
    instance.PlayerCast:SetSize(dimensions.width, dimensions.height)
    instance.PlayerCast:SetAllPoints()
    instance.PlayerCast:SetDrawBling(false)
    instance.PlayerCast:SetDrawEdge(false)
    instance.PlayerCastSet = this.PlayerCastSet
    instance.PlayerCast:SetSwipeTexture("Interface/AddOns/TheEyeAddon/UI/Textures/TargetFrame_PlayerCast.blp")
]]
    instance.RaidMarker = instance.RaidMarker or TextureCreate(instance, "ARTWORK")
    instance.RaidMarker:SetSize(dimensions.width * 0.35, dimensions.height * 0.35)
    instance.RaidMarker:SetPoint("CENTER", instance, "TOP", 0, -dimensions.height * 0.07)
    instance.RaidMarkerSet = this.RaidMarkerSet

    instance.Health = instance.Health or FontStringCreate(instance)
    instance.Health:StyleSet("OVERLAY", TheEyeAddon.Values.FontTemplates.TargetFrame.Health, "CENTER")
    instance.HealthSet = this.HealthSet

    instance.Name = instance.Name or FontStringCreate(instance)
    instance.Name:StyleSet("OVERLAY", TheEyeAddon.Values.FontTemplates.TargetFrame.Name, nil)
    instance.Name:SetPoint("TOP", instance, "TOP", 0, -dimensions.height * 0.12)
    instance.NameSet = this.NameSet

    local width = (#dotSpellIDs * TheEyeAddon.Values.DimensionTemplates.Icon.TargetFrameDoT.width) + (dotPadding * (#dotSpellIDs - 1))
    instance.DoTs = instance.DoTs or CreateFrame("Frame", nil, instance)
    instance.DoTs:SetSize(width, TheEyeAddon.Values.DimensionTemplates.Icon.TargetFrameDoT.height)
    instance.DoTs:SetPoint("BOTTOM", instance, "BOTTOM", 0, dimensions.height * 0.1)
    instance.DoTSet = this.DoTSet
    this.DoTsSetup(instance.DoTs, width, dotSpellIDs)

    return instance
end
--[[
function this:PlayerCastSet(isActive, startTime, duration, isReverse)
    if isActive == true then
        --print("startTime: " .. startTime .. ", duration: " .. duration)
        --self.PlayerCast:Show()
        --self.PlayerCast:SetReverse(isReverse)
        --self.PlayerCast:SetCooldown(startTime, duration)
    else
        self.PlayerCast:Hide()
    end
end]]

function this:RaidMarkerSet(index)
    self.RaidMarker:SetTexture(TheEyeAddon.Values.raidMarkerFileIDs[index])
end

function this:HealthSet(percent)
    local unitName = UnitName(self.unit)

    if unitName ~= nil then
        self.Health:SetText(tostring(math.floor((percent * 100) + 0.5)))
    else
        self.Health:SetText("")
    end
end

function this:NameSet(name)
    self.Name:SetText(name)
end

function this.DoTsSetup(instance, parentWidth, dotSpellIDs)
    local spacing = parentWidth / #dotSpellIDs
    local width = TheEyeAddon.Values.DimensionTemplates.Icon.TargetFrameDoT.width
    local height = TheEyeAddon.Values.DimensionTemplates.Icon.TargetFrameDoT.height
    instance.Icons = instance.Icons or {}

    for i = 1, #dotSpellIDs do
        local xOffset = (width * (i - 1)) + (dotPadding * (i - 1))
        local fileID = select(3, GetSpellInfo(dotSpellIDs[i]))

        instance.Icons[i] = instance.Icons[i] or TextureCreate(instance, "OVERLAY")
        instance.Icons[i]:SetPoint("LEFT", instance, "LEFT", xOffset, 0)
        instance.Icons[i]:SetSize(width, height)
        instance.Icons[i]:SetTexture(fileID)
        instance.Icons[i].spellID = dotSpellIDs[i]
    end

    for i = 1, #instance.Icons do
        instance.Icons[i]:Hide()
    end
end

function this:DoTSet(spellID, isVisible)
    local icons = self.DoTs.Icons
    for i = 1, #icons do
        if icons[i].spellID == spellID then
            if isVisible == true then
                icons[i]:Show()
            else
                icons[i]:Hide()
            end
        end
    end
end