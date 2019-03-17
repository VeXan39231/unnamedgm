AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
 
	self:SetModel( "models/cocn.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( "originalAmount", 5 )
 	self:SetNWInt( "amountLeft", 5 )

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end

end

function ENT:Use( act, cal )


	if IsValid( act ) then
		
		--print( self:GetNWInt( "amountLeft" ) )

		if self:GetNWInt( "amountLeft" ) < 2 then
			self:Remove()
		else
			self:SetNWInt( "amountLeft", self:GetNWInt( "amountLeft" ) - 1 )
		end

		act:SetWalkSpeed( 290 )
		act:SetRunSpeed( 380 )
		act:SetJumpPower( 200 )

		timer.Simple( math.random( 6, 30 ), function()
			act:SetWalkSpeed( 200 )
			act:SetRunSpeed( 320 )
			act:SetJumpPower( 160 )
		end )

	end

end