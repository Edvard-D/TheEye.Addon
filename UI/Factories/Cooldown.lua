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
	
	instance.Text = instance.Text or FontStringCreate(instance)
    instance.Text:StyleSet("OVERLAY", TheEyeAddon.Values.FontTemplates.Icon.Cooldown, "CENTER")

	return instance
end

function this:CooldownStart(spellID)
	self.spellID = spellID
    local startTime, duration = GetSpellCooldown(spellID)
	self:SetCooldown(startTime, duration)
	
	self.customEvents = { "UPDATE", }
    EventRegister(self)
    self.OnEvent = this.OnEvent
end

function this:OnEvent(event)
	local startTime, duration = GetSpellCooldown(self.spellID)
	local remainingTime = duration - (GetTime() - startTime)

    self.Text:SetText(tostring(math.floor(remainingTime + 0.5)))
end