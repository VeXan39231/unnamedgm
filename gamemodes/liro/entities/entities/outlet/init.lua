AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )
util.AddNetworkString( "getPlugInfo" )
util.AddNetworkString( "sendPlugInfo" )

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/powerbox02b.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( "maxp", 3 )
	self:SetNWInt( "curp", 0 )

end

end

net.Receive( "getPlugInfo", function() 

	local plug = net.ReadEntity()

	local m, c = plug:GetNWInt( "maxp" ), plug:GetNWInt( "curp" )

	net.Start( "sendPlugInfo" )
		net.WriteInt( m, 32 )
		net.WriteInt( c, 31 )
	net.Broadcast()

end )