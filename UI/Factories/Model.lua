TheEye.Core.UI.Factories.Model = {}
local this = TheEye.Core.UI.Factories.Model

local After = C_Timer.After
local FrameClaim = TheEye.Core.Managers.FramePools.FrameClaim
local unpack = unpack

local methods =
{
    ModelSet = function(self, fileID)
        if fileID ~= nil then
            self:SetModel(tonumber(fileID))

            After(0.001, function()
                self:Redraw()
            end)
        end
    end,
    ModelShowAndSet = function(self, fileID)
        self:Show()

        After(0.001, function()
            self:ModelSet(fileID)
        end)
    end,
    Redraw = function(self)
        local offset = (0.205 * self.size) / 1000
        
        self:ClearTransform()
        self:SetTransform(
            offset, offset, 0,
            rad(self.rotation.X), rad(self.rotation.Y), rad(self.rotation.Z),
            self.scale / 1000)
        self:MakeCurrentCameraCustom()
    end,
    RotationSet = function(self, rotation)
        self.rotation = rotation
    end,
    ScaleSet = function(self, scale)
		self.scale = scale
    end,
    SizeSet = function(self, size)
        self.size = size
        self:SetSizeWithEvent(size, size)
    end,
}

function this.Claim(uiObject, parentFrame, dimensions, fileID)
    local modelFrame = FrameClaim(uiObject, "Model", parentFrame, nil, dimensions)
    
    for key, value in pairs(methods) do
        modelFrame[key] = value
    end

    modelFrame:SizeSet(dimensions.size)
    modelFrame:ScaleSet(dimensions.scale)
    modelFrame:RotationSet(dimensions.rotation)
    modelFrame:ModelSet(fileID)

    return modelFrame
end