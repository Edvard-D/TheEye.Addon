TheEye.Core.UI.Factories.TargetFrame = {}
local this = TheEye.Core.UI.Factories.TargetFrame

local backgroundRotationRate = -0.0025
local dotPadding = 5
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FrameClaim = TheEye.Core.Managers.FramePools.FrameClaim
local GetSpellInfo = GetSpellInfo
local math = math
local midRotationRate = -0.01
local overlayRotationRate = -0.005
local select = select
local TextureCreate = TheEye.Core.UI.Factories.Texture.Create
local tostring = tostring
local UnitName = UnitName
local unpack = unpack


function this.Claim(uiObject, parentFrame, dimensions, unit, dotSpellIDs)
    local instance = FrameClaim(uiObject, "TargetFrame", parentFrame, nil, dimensions)
    local spec = GetSpecializationInfo(GetSpecialization())
    local colors = TheEye.Core.Data.Colors[spec].TargetFrame
    local texturePaths = TheEye.Core.Data.TexturePaths.TargetFrame
    instance.unit = unit

    
    instance.Background = instance.Background or TextureCreate(instance, "BACKGROUND", -8, "BLEND")
    instance.Background:TextureSet(texturePaths.background)
    instance.Background:SetVertexColor(unpack(colors.background))
    instance.Background:RotationStart(backgroundRotationRate)

    instance.Swirl = instance.Swirl or TextureCreate(instance, "BACKGROUND", -7, "BLEND")
    instance.Swirl:TextureSet(texturePaths.mid)
    instance.Swirl:SetVertexColor(unpack(colors.mid))
    instance.Swirl:RotationStart(midRotationRate)
    
    instance.Overlay = instance.Overlay or TextureCreate(instance, "BACKGROUND", -6, "BLEND")
    instance.Overlay:TextureSet(texturePaths.overlay)
    instance.Overlay:SetVertexColor(unpack(colors.overlay))
    instance.Overlay:RotationStart(overlayRotationRate)

    instance.RaidMarker = instance.RaidMarker or TextureCreate(instance, "ARTWORK")
    instance.RaidMarker:SetSize(dimensions.width * 0.35, dimensions.height * 0.35)
    instance.RaidMarker:SetPoint("CENTER", instance, "TOP", 0, -dimensions.height * 0.07)
    instance.RaidMarkerSet = this.RaidMarkerSet
    instance:RaidMarkerSet(nil)

    instance.Health = instance.Health or FontStringCreate(instance)
    instance.Health:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame.Health, "CENTER")
    instance.HealthSet = this.HealthSet

    instance.Name = instance.Name or FontStringCreate(instance)
    instance.Name:StyleSet("OVERLAY", TheEye.Core.Data.FontTemplates.TargetFrame.Name, nil)
    instance.Name:SetPoint("TOP", instance, "TOP", 0, -dimensions.height * 0.12)
    instance.NameSet = this.NameSet


    challengeWidth = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameChallenge.width
    challengeHeight = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameChallenge.height
    instance.ChallengeSet = this.ChallengeSet
    instance.challengeAlignment = "centerAlign"

    instance.ChallengeContainer = instance.ChallengeContainer or CreateFrame("Frame", nil, instance)
    instance.ChallengeContainer:SetSize(challengeWidth, challengeHeight)
    instance.ChallengeContainer:SetPoint("RIGHT", instance.Name, "LEFT", -3, 0)

    instance.ChallengeBorder = instance.ChallengeBorder or TextureCreate(instance.ChallengeContainer, "OVERLAY")
    instance.ChallengeBorder:SetPoint("CENTER", instance.ChallengeContainer, "CENTER")
    instance.ChallengeBorder:SetSize(challengeWidth, challengeHeight)

    instance.ChallengeSymbol = instance.ChallengeSymbol or TextureCreate(instance.ChallengeContainer, "OVERLAY")
    instance.ChallengeSymbol:SetPoint("CENTER", instance.ChallengeContainer, "CENTER")
    instance.ChallengeSymbol:SetSize(challengeWidth, challengeHeight)


    local width = (#dotSpellIDs * TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameDoT.width) + (dotPadding * (#dotSpellIDs - 1))
    instance.DoTs = instance.DoTs or CreateFrame("Frame", nil, instance)
    instance.DoTs:SetSize(width, TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameDoT.height)
    instance.DoTs:SetPoint("BOTTOM", instance, "BOTTOM", 0, dimensions.height * 0.1)
    instance.DoTSet = this.DoTSet
    this.DoTsSetup(instance.DoTs, width, dotSpellIDs)

    return instance
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
    local unitName = UnitName(self.unit)

    if unitName ~= nil then
        self.Health:SetText(tostring(math.floor((percent * 100) + 0.5)))
    else
        self.Health:SetText("")
    end
end

function this:ChallengeSet(targetClassification, targetLevel, playerLevel, targetReaction, isTargetPlayer, targetFaction)
    local colors = TheEye.Core.Data.Colors.TargetFrame.challenge
    local texturePaths = TheEye.Core.Data.TexturePaths.TargetFrame.Challenge[self.challengeAlignment]
    local borderVersion = 0
    local levelDifference = targetLevel - playerLevel

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

function this.DoTsSetup(instance, parentWidth, dotSpellIDs)
    local spacing = parentWidth / #dotSpellIDs
    local width = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameDoT.width
    local height = TheEye.Core.Data.DimensionTemplates.Icon.TargetFrameDoT.height
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