----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

include("shared.lua");

function ENT:Initialize()
	self.itemTable = IA.Items:GetItem(self.Unique);
	
	self:SetModel(self.itemTable.Model);
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	
	local pObject = self:GetPhysicsObject();
	
	if (IsValid( pObject )) then
		pObject:Wake();
	end;
	
	self:SetNetworkedString("ia_Name", self.itemTable.Name);
end

function ENT:Use( activator, caller )
	if (!activator:IsPlayer()) then return false; end;

	activator:GiveItem(self.Unique, 1);
	activator:EmitSound("items/ammocrate_open.wav");
	self:Remove();
	activator:ChatPrint("Picked up " .. self.itemTable.Name .. ".");
end;