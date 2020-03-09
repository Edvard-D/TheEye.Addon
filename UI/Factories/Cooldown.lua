TheEye.Core.UI.Factories.Cooldown = {}
local this = TheEye.Core.UI.Factories.Cooldown

local EventRegister = TheEye.Core.Managers.Events.Register
local FontStringCreate = TheEye.Core.UI.Factories.FontString.Create
local FrameClaim = TheEye.Core.Managers.FramePools.FrameClaim


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