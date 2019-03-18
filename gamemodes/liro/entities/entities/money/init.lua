AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

function ENT:Initialize()
 
	self:SetModel( "models/props/cs_assault/money.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWInt( "amount", 0 )

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end

end

function ENT:Use( act, cal )


	if IsValid( act ) then
		
		cdata.addMoney( act, self:GetNWInt( "amount" ) )
		SendChat( act, "You picked up $" .. self:GetNWInt( "amount" ), true )
		self:Remove()

	end

end

--fuck money merging
--[[
function ENT:Touch( mon )

	if mon:GetClass() == "money" then
		
		mon:SetNWInt( "amount", self:GetNWInt( "amount" ) + mon:GetNWInt( "amount" ) )
		ENT:Remove()

	end

end
]]--