-- vim: fdm=marker se sw=4 ts=4 :

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

--{{{1
SWEP.Weight         = 0
SWEP.AutoSwitchTo   = false
SWEP.AutoSwitchFrom = false

function SWEP:GetCapabilities() --{{{1
	return 0
end
