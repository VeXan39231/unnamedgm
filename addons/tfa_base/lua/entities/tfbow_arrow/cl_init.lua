
-- Copyright (c) 2018 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

include("shared.lua")
local cv_ht = GetConVar("host_timescale")

function ENT:Draw()
	local ang, tmpang
	tmpang = self:GetAngles()
	ang = tmpang

	if not self.roll then
		self.roll = 0
	end

	local phobj = self:GetPhysicsObject()

	if IsValid(phobj) then
		self.roll = self.roll + phobj:GetVelocity():Length() / 3600 * cv_ht:GetFloat()
	end

	ang:RotateAroundAxis(ang:Forward(), self.roll)
	self:SetAngles(ang)
	self:DrawModel() -- Draw the model.
	self:SetAngles(tmpang)
end
