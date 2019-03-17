----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

IA.Items = {};
IA.Items.Stored = {};

function IA.Items:RegisterItem( itemUnique, itemTable )
	self.Stored[itemUnique] = itemTable;
	self.Stored[itemUnique].Name = itemTable.Name or "";
	self.Stored[itemUnique].Info = itemTable.Info or "";
	self.Stored[itemUnique].Model = itemTable.Model or "";
	self.Stored[itemUnique].useAble = itemTable.useAble or 1;
	self.Stored[itemUnique].dropAble = itemTable.dropAble or 1;
	self.Stored[itemUnique].isWeapon = itemTable.isWeapon or 0
	
	if (SERVER) then
		self.Stored[itemUnique].UseItem = itemTable.UseItem or function( ply ) end;
		self.Stored[itemUnique].DropItem = itemTable.DropItem or function( ply ) end;
	end;
	
	print("[INV] - Created item '" .. itemTable.Name .. "'.");
end;

function IA.Items:GetItem( item )
	if (self.Stored[item] != nil) then
		return self.Stored[item];
	end;
end;

for k, v in pairs( file.Find("items/*.lua", "LUA") ) do
	include("items/" .. v);
	
	if (SERVER) then
		AddCSLuaFile("items/" .. v);
	end;
end;

if (SERVER) then
	concommand.Add("ia_item_use", function( ply, cmd, args )
		local item = args[ 1 ];
		
		if (IA.Items.Stored[item] != nil) then
			if (ply:HasItem(item)) then
				local itemTable = IA.Items:GetItem(item);
				
				itemTable:UseItem(ply);
			end;
		end;
	end);
	
	concommand.Add("ia_item_drop", function( ply, cmd, args )
		local item = args[ 1 ];
		
		if (IA.Items.Stored[item] != nil) then
			if (ply:HasItem(item)) then
				local itemTable = IA.Items:GetItem(item);
				
				itemTable:DropItem(ply);
				ply:EmitSound("items/ammocrate_close.wav");
			end;
		end;
	end);

	concommand.Add( "ia_item_getammo", function( ply, cmd, args )
		local item = args[1]
		if (IA.Items.Stored[item] != nil) then
			if (ply:HasItem(item)) then
				local itemTable = IA.Items:GetItem(item);
				local wep = weapons.GetStored( "tfcss_" .. item )
				local ammo = wep.Primary.Ammo

				ply:GiveAmmo( 30, ammo );
				ply:EmitSound("weapons/ak47/ak47_boltpull.wav");
				ply:RemoveItem( item, 1 )
			end;
		end;

	end )

end;