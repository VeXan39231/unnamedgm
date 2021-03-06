
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

--[[ AddCSLua our other essential functions. ]]--
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--[[ Load up our shared code. ]]--
include("shared.lua")

--[[ Include these modules]]--
for _, v in pairs(SWEP.SV_MODULES) do
	include(v)
end

--[[ Include these modules, and AddCSLua them, since they're shared.]]--
for _, v in pairs(SWEP.SH_MODULES) do
	AddCSLuaFile(v)
	include(v)
end

--[[ Include these modules if singleplayer, and AddCSLua them, since they're clientside.]]--
for _, v in pairs(SWEP.ClSIDE_MODULES) do
	AddCSLuaFile(v)
end

if game.SinglePlayer() then
	for _, v in pairs(SWEP.ClSIDE_MODULES) do
		include(v)
	end
end

--[[Actual serverside values]]--
SWEP.Weight = 60 -- Decides whether we should switch from/to this
SWEP.AutoSwitchTo = true -- Auto switch to
SWEP.AutoSwitchFrom = true -- Auto switch from
