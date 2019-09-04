TheEyeAddon.UI.Factories.Cooldown = {}
local this = TheEyeAddon.UI.Factories.Cooldown

local EventRegister = TheEyeAddon.Managers.Events.Register
local FontStringCreate = TheEyeAddon.UI.Factories.FontString.Create
local FrameClaim = TheEyeAddon.Managers.FramePools.FrameClaim


function this.Claim(uiObject, parentFrame, dimensions)
	local instance = FrameClaim(uiObject, "Cooldown", parentFrame, "CooldownFrameTemplate", dimensions)

	instance.CooldownStart = this.CooldownStart

    instance:SetAllPoints()
    instance:SetDrawBling(false)
	instance:SetDrawEdge(false)

	return instance
end

function this:CooldownStart(spellID)
	self.spellID = spellID
    local startTime, duration = GetSpellCooldown(spellID)
	self:SetCooldown(startTime, duration)
end