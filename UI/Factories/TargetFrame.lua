TheEye.Core.UI.Factories.TargetFrame = {}
local this = TheEye.Core.UI.Factories.TargetFrame

local auraPadding = 5
local backgroundRotationRate = -0.0025
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FrameClaim = TheEye.Core.Managers.FramePools.FrameClaim
local GetSpellInfo = GetSpellInfo
local locale = LibStub("AceLocale-3.0"):GetLocale("TheEye.Core", true)
local math = math
local midRotationRate = -0.01
local overlayRotationRate = -0.005
local select = select
local TextureCreate = TheEye.Core.UI.Factories.Texture.Create
local timeUntilDeathMax = 600 -- seconds = 10 minutes
local timeUntilDeathUpdateDelay = 1 -- second
local tostring = tostring
local UnitName = UnitName
local unpack = unpack


function this.Claim(uiObject, parentFrame, dimensions, frameType, auraSpellIDs)
    local instance = FrameClaim(uiObject, "TargetFrame", parentFrame, nil, dimensions)
    instance.frameType = frameType

    local spec = GetSpecializationInfo(GetSpecialization())
    local colors = TheEye.Core.Data.Colors[spec].TargetFrame
    local texturePaths = TheEye.Core.Data.TexturePaths.TargetFrame

    local size = nil
    local yOffset = nil
    local point = nil
    local relativeTo = nil
    local relativePoint = nil

    -- Background
    if frameType == "PRIMARY" then
        instance.Background = instance.Background or TextureCreate(instance, "BACKGROUND", -8, "BLEND")
        instance.Background:TextureSet(texturePaths.background)
        instance.Background:SetVertexColor(unpack(colors.background))
        instance.Background:RotationStart(backgroundRotationRate)
        instance.Background:Show()

        instance.Swirl = instance.Swirl or TextureCreate(instance, "BACKGROUND", -7, "BLEND")
        instance.Swirl:TextureSet(texturePaths.mid)
        instance.Swirl:SetVertexColor(unpack(colors.mid))
        instance.Swirl:RotationStart(midRotationRate)
        instance.Swirl:Show()
        
        instance.Overlay = instance.Overlay or TextureCreate(instance, "BACKGROUND", -6, "BLEND")
        instance.Overlay:TextureSet(texturePaths.overlay)
        instance.Overlay:SetVertexColor(unpack(colors.overlay))
        instance.Overlay:RotationStart(overlayRotationRate)
        instance.Overlay:Show()

        instance.EffectAttachPoint = instance.EffectAttachPoint or CreateFrame("Frame", nil, instance)
        instance.EffectAttachPoint:SetAllPoints(instance)
    else -- INTERACTION
        if instance.Background ~= nil then
            instance.Background:Hide()
        end
        if instance.Swirl ~= nil then
            instance.Swirl:Hide()
        end
        if instance.Overlay ~= nil then
            instance.Overlay:Hide()
        end
    end

    -- Health
    instance.Health = instance.Health or FontStringCreate(instance)
    instance.Health:ClearAllPoints()
    if frameType == "PRIMARY" then
        instance.Health:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame[frameType].Health.IsNotBoss, "CENTER")
    else -- INTERACTION
        instance.Health:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame[frameType].Health, "RIGHT", instance, "LEFT", -5, 0)
    end
    instance.HealthSet = this.HealthSet

    -- Raid Marker
    if frameType == "PRIMARY" then
        size = dimensions.width * 0.35
        point = "CENTER"
        relativeTo = instance
        relativePoint = "TOP"
        yOffset = size * 0.01
    else -- INTERACTION
        size = dimensions.height * 0.5
        point = "BOTTOM"
        relativeTo = instance.Health
        relativePoint = "TOP"
        yOffset = -size * 0.25
    end

    instance.RaidMarker = instance.RaidMarker or TextureCreate(instance, "ARTWORK")
    instance.RaidMarker:SetSize(size, size)
    instance.RaidMarker:ClearAllPoints()
    instance.RaidMarker:SetPoint(point, relativeTo, relativePoint, 0, yOffset)
    instance.RaidMarkerSet = this.RaidMarkerSet
    instance:RaidMarkerSet(nil)

    -- Name and Challenge
    if instance.Name ~= nil then
        instance.Name:ClearAllPoints()
    end
    if instance.ChallengeContainer ~= nil then
        instance.ChallengeContainer:ClearAllPoints()
    end

    if frameType == "PRIMARY" then
        this.NameSetup(instance, dimensions, frameType)
        this.ChallengeSetup(instance, dimensions, frameType)
    else -- INTERACTION
        this.ChallengeSetup(instance, dimensions, frameType)
        this.NameSetup(instance, dimensions, frameType)
    end

    -- Auras
    local width = (#auraSpellIDs * TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameAura[frameType].width) + (auraPadding * (#auraSpellIDs - 1))
    instance.AurasContainer = instance.AurasContainer or CreateFrame("Frame", nil, instance)
    instance.AurasContainer:SetSize(width, TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameAura[frameType].height)
    instance.AurasContainer:ClearAllPoints()
    if frameType == "PRIMARY" then
        instance.AurasContainer:SetPoint("BOTTOM", instance, "BOTTOM", 0, dimensions.height * 0.1)
    else
        instance.AurasContainer:SetPoint("BOTTOM", instance, "BOTTOM", 0, 0)
        instance.AurasContainer:SetPoint("LEFT", instance, "LEFT", 0, 0)
    end
    instance.AuraSet = this.AuraSet
    this.AurasSetup(instance.AurasContainer, frameType, width, auraSpellIDs)
    
    -- Is Boss
    instance.IsBossSet = this.IsBossSet

    -- Time Until Death
    instance.TimeUntilDeath = instance.TimeUntilDeath or FontStringCreate(instance)
    instance.TimeUntilDeath:ClearAllPoints()
    if frameType == "PRIMARY" then
        instance.TimeUntilDeath:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame[frameType].TimeUntilDeath, "TOP", instance.Health, "BOTTOM", 0, -2.5)
    else -- INTERACTION
        instance.TimeUntilDeath:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame[frameType].TimeUntilDeath, "LEFT", instance.AurasContainer, "RIGHT", 3, 0)
    end
    instance.TimeUntilDeath:SetText("")
    instance.TimeUntilDeathSet = this.TimeUntilDeathSet

    return instance
end

function this.NameSetup(instance, dimensions, frameType)
    instance.Name = instance.Name or FontStringCreate(instance)
    instance.Name:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame[frameType].Name, nil)
    instance.Name:ClearAllPoints()
    if frameType == "PRIMARY" then
        instance.Name:SetPoint("TOP", instance, "TOP", 0, -dimensions.height * 0.12)
    else -- INTERACTION
        instance.Name:SetPoint("LEFT", instance.ChallengeContainer, "RIGHT", 3, 0)
    end
    instance.NameSet = this.NameSet
end

function this.ChallengeSetup(instance, dimensions, frameType)
    if frameType == "PRIMARY" then
        size = dimensions.width * 0.25
    else -- INTERACTION
        size = dimensions.height * 0.5
    end
    instance.ChallengeSet = this.ChallengeSet
    instance.challengeAlignment = "centerAlign"

    instance.ChallengeContainer = instance.ChallengeContainer or CreateFrame("Frame", nil, instance)
    instance.ChallengeContainer:SetSize(size, size)
    if frameType == "PRIMARY" then
        instance.ChallengeContainer:SetPoint("RIGHT", instance.Name, "LEFT", -3, 0)
    else -- INTERACTION
        instance.ChallengeContainer:SetPoint("TOP", instance, "TOP", 0, 0)
        instance.ChallengeContainer:SetPoint("LEFT", instance, "LEFT", 0, 0)
    end

    instance.ChallengeBorder = instance.ChallengeBorder or TextureCreate(instance.ChallengeContainer, "OVERLAY")
    instance.ChallengeBorder:SetPoint("CENTER", instance.ChallengeContainer, "CENTER")
    instance.ChallengeBorder:SetSize(size, size)

    instance.ChallengeSymbol = instance.ChallengeSymbol or TextureCreate(instance.ChallengeContainer, "OVERLAY")
    instance.ChallengeSymbol:SetPoint("CENTER", instance.ChallengeContainer, "CENTER")
    instance.ChallengeSymbol:SetSize(size, size)
end

function this:RaidMarkerSet(index)
    if index ~= nil then
        local textureFileID = TheEye.Core.Data.raidMarkerFileIDs[index]
        self.RaidMarker:SetTexture(textureFileID)
    else
        self.RaidMarker:SetTexture(nil)
    end
end

function this:HealthSet(percent)
    percent = math.floor((percent * 100) + 0.5)

    if percent < 0 then
        percent = 0
    end

    self.Health:SetText(tostring(percent))
end

function this:ChallengeSet(targetClassification, targetLevel, playerLevel, targetReaction, isTargetPlayer, targetFaction)
    if targetLevel == 0 then
        return
    end

    local colors = TheEye.Core.Data.Colors.TargetFrame.challenge
    local texturePaths = TheEye.Core.Data.TexturePaths.TargetFrame.Challenge[self.challengeAlignment]
    local borderVersion = 0
    local levelDifference = targetLevel - playerLevel

    --print("targetLevel: " .. targetLevel)
    if targetLevel == -1 then
        self.ChallengeSymbol:TextureSet(texturePaths["symbol6"])
        borderVersion = 3
    elseif targetClassification == "trivial" and isTargetPlayer == false then
        self.ChallengeSymbol:TextureSet(texturePaths["symbol1"])
    elseif targetClassification == "minus" then
        self.ChallengeSymbol:TextureSet(texturePaths["symbol2"])
    elseif levelDifference == 0 or (targetClassification == "trivial" and isTargetPlayer == true) then
        self.ChallengeSymbol:TextureSet(texturePaths["symbol3"])
        borderVersion = 1
    elseif levelDifference == 1 then
        self.ChallengeSymbol:TextureSet(texturePaths["symbol4"])
        borderVersion = 2
    else
        self.ChallengeSymbol:TextureSet(texturePaths["symbol5"])
        borderVersion = 3
    end
    
    if targetReaction < 4 then
        self.ChallengeSymbol:SetVertexColor(unpack(colors["red"]))
    elseif targetReaction > 4 then
        self.ChallengeSymbol:SetVertexColor(unpack(colors["green"]))
    else
        self.ChallengeSymbol:SetVertexColor(unpack(colors["yellow"]))
    end
    
    if isTargetPlayer == true
        or targetClassification == "worldboss"
        or targetClassification == "elite"
        or targetClassification == "rareelite"
        or targetClassification == "rare"
        then
        self.ChallengeBorder:Show()
        self.ChallengeBorder:TextureSet(texturePaths["border" .. borderVersion])
        
        if isTargetPlayer == true then
            if targetFaction == "Alliance" then
                self.ChallengeBorder:SetVertexColor(unpack(colors["blue"]))
            else -- Horde
                self.ChallengeBorder:SetVertexColor(unpack(colors["red"]))
            end
        elseif targetClassification == "elite" then
            self.ChallengeBorder:SetVertexColor(unpack(colors["gold"]))
        else
            self.ChallengeBorder:SetVertexColor(unpack(colors["silver"]))
        end
    else
        self.ChallengeBorder:Hide()
    end
end

function this:NameSet(name)
    self.Name:SetText(name)
end

function this.AurasSetup(instance, frameType, parentWidth, auraSpellIDs)
    local spacing = parentWidth / #auraSpellIDs
    local width = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameAura[frameType].width
    local height = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameAura[frameType].height
    instance.Icons = instance.Icons or {}

    for i = 1, #auraSpellIDs do
        local xOffset = (width * (i - 1)) + (auraPadding * (i - 1))
        local fileID = select(3, GetSpellInfo(auraSpellIDs[i]))

        instance.Icons[i] = instance.Icons[i] or TextureCreate(instance, "OVERLAY")
        instance.Icons[i]:SetPoint("LEFT", instance, "LEFT", xOffset, 0)
        instance.Icons[i]:SetSize(width, height)
        instance.Icons[i]:SetTexture(fileID)
        instance.Icons[i].spellID = auraSpellIDs[i]
    end

    for i = 1, #instance.Icons do
        instance.Icons[i]:Hide()
    end
end

function this:AuraSet(spellID, isVisible)
    local icons = self.AurasContainer.Icons
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

function this:IsBossSet(isBoss)
    if isBoss == true then
        self.TimeUntilDeath:Show()
    else
        self.TimeUntilDeath:Hide()
    end

    if self.frameType == "PRIMARY" then
        if isBoss == true then
            self.Health:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame.PRIMARY.Health.IsBoss, "CENTER", self, "CENTER", 0, 7.5)
        else
            self.Health:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame.PRIMARY.Health.IsNotBoss, "CENTER")
        end
    end
end

function this:TimeUntilDeathSet(health, healthChangePerSecond)
    if self.timeUntilDeathUpdateTimestamp ~= nil
        and GetTime() - self.timeUntilDeathUpdateTimestamp < timeUntilDeathUpdateDelay
        then
        return
    end
    
    self.timeUntilDeathUpdateTimestamp = GetTime()
    local timeUntilDeath = nil
    local secondsUntilDeath = (health / healthChangePerSecond) * -1

    if healthChangePerSecond >= 0 then
        timeUntilDeath = "∞"
    elseif healthChangePerSecond < 0 then
        local secondsUntilDeath = (health / healthChangePerSecond) * -1

        local prefix = ""
        if secondsUntilDeath > timeUntilDeathMax then
            secondsUntilDeath = timeUntilDeathMax
            prefix = ">"
        end

        local minutes = math.floor(secondsUntilDeath / 60)
        local seconds = math.floor(secondsUntilDeath - (minutes * 60) + 0.5)

        if minutes > 0 then
            if seconds < 10 then
                seconds = table.concat({ "0", seconds })
            end

            timeUntilDeath = table.concat({ prefix, minutes, ":", seconds })
        else
            local suffix = ""

            if seconds == 1 then
                suffix = " " .. locale["sec"]
            else
                suffix = " " .. locale["secs"]
            end

            timeUntilDeath = table.concat({ prefix, seconds, suffix })
        end
    end
    
    self.TimeUntilDeath:SetText(timeUntilDeath)
end