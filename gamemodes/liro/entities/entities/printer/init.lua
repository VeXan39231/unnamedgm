AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )
util.AddNetworkString( "getPrinterInfo" )
util.AddNetworkString( "sendPrinterInfo" )

function ENT:Initialize()
 
	self:SetModel( "models/props_lab/reciever01b.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( "money", 0 )

	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end

end

function ENT:Use( act, cal, type, val )

	if not ( self:GetNWBool( "powered" ) ) then
		
		act:SetNWEntity( "pwent", self )

	end

	local money = ents.Create( "money" )
	local amt = self:GetNWInt( "money" )

	if amt != 0 then

		money:SetPos( self:GetPos() + Vector( 0, 0, 2 ) )
		money:Spawn()
		money:SetNWInt( "amount", amt )

		self:SetNWInt( "money", 0 )

	end 

end

net.Receive( "getPrinterInfo", function() 

	local printer = net.ReadEntity()

	local m = printer:GetNWInt( "money" )
	--if o == nil then o = "Nobody" end

	net.Start( "sendPrinterInfo" )
		net.WriteInt( m, 32 )
	net.Broadcast()

end )