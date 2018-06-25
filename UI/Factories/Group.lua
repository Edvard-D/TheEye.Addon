local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Group = {}


local function Release()
	self.isClaimed = false
	self:SetParent(nil)
	self:Hide()
end