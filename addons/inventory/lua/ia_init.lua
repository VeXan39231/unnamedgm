----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

require("glon");

IA = {};

-- Put someones steamid like this in the table to allow them spawning items: "STEAM_0:0:0000".
IA.allowSpawning = {
};

AddCSLuaFile("autorun/ia_loader.lua");
AddCSLuaFile("ia_cl_init.lua");
AddCSLuaFile("ia_shared.lua");
AddCSLuaFile("ia_items.lua");

include("ia_shared.lua");
include("ia_items.lua");

if (IA.Config["bindF4"]) then
	hook.Add("ShowSpare2", "ia_Menu", function( ply )
		ply:ConCommand("ia_inventory");
	end);
end;

local meta = FindMetaTable("Player");

function meta:SpawnItem( item )
	if (IA.Items.Stored[item] != nil) then
		local tr = self:EyeTrace(100);
		
		local entItem = ents.Create("ia_item");
		entItem:SetPos(tr.HitPos);
		entItem.Unique = item;
		entItem:Spawn();
	end;
end;

function meta:HasItem( item )

	if (self.ia_Inventory[item] == nil) then
		return false;
	end;
	
	return self.ia_Inventory[item] >= 1;
	
end;


function meta:GiveItem( item, amount )
	local inventory = self.ia_Inventory;
	
	if not amount then amount = 1 end

	if (!inventory[item]) then
		inventory[item] = 0;
		inventory[item] = inventory[item] + amount;
	else
		inventory[item] = inventory[item] + amount;
	end;
	
	umsg.Start("ia_giveItem", self);
		umsg.String(item);
		umsg.Long(amount);
	umsg.End();
end;

function meta:RemoveItem( item, amount )
	local inventory = self.ia_Inventory;

	if not amount then amount = 1 end
	
	if (inventory[item] != nil and inventory[item] >= 1) then
		inventory[item] = inventory[item] - amount;
		
		umsg.Start("ia_removeItem", self);
			umsg.String(item);
			umsg.Long(inventory[item]);
		umsg.End();
	end;
	
	-- Fixed the 'Count: 0' here.
	if (inventory[item] == 0) then
		inventory[item] = nil;
	end;
end;

function meta:SaveInventory()
	local Data = glon.encode(self.ia_Inventory);
	file.Write("InventoryAddon/" .. self:SteamID64() .. ".txt", Data);
end;

-- Load player.
hook.Add("PlayerInitialSpawn", "ia_loadData", function( ply )
	ply.ia_Inventory = {};
	
	if (file.Exists( "InventoryAddon/" .. ply:SteamID64() .. ".txt", "DATA" )) then
		local Data = glon.decode(file.Read( "InventoryAddon/" .. ply:SteamID64() .. ".txt" ));
		
		ply.ia_Inventory = Data;
		
		timer.Simple(3, function() -- If the player has slow spawn it might not get sent to him/her, so a delay.
			ply:ChatPrint("[Inventory Addon ] - Sending saved inventory");
			
			for k, v in pairs( ply.ia_Inventory ) do
				umsg.Start("ia_savedItems", ply);
					umsg.String(k);
					umsg.Long(v);
				umsg.End();
			end;
			
			ply:ChatPrint("[Inventory Addon ] - Done sending saved inventory");
		end, ply );
	else
		ply:SaveInventory();
	end;
end);

-- Saving player on disconnect.
hook.Add("PlayerDisconnected", "ia_saveData", function( ply )
	ply:SaveInventory();
end);

-- Does this even work?
hook.Add("ShutDown", "ia_saveDataShutdown", function()
	for _, ply in ipairs( player.GetAll() ) do
		ply:SaveInventory();
	end;
end);

concommand.Add("ia_spawnitem", function( ply, cmd, args )
	if (table.HasValue(IA.allowSpawning, ply:SteamID()) or ply:IsAdmin()) then
		local item = args[ 1 ] or "";
		
		if (IA.Items.Stored[item] != nil) then
			ply:SpawnItem(item);
		else
			ply:PrintMessage(2, "Invalid item: '" .. item .. "'\nType 'ia_showitems' in console to see available items!");
			return;
		end;
	end;
end);

concommand.Add("ia_showitems", function( ply, cmd, args )
	if (table.HasValue(IA.allowSpawning, ply:SteamID()) or ply:IsAdmin()) then
		ply:PrintMessage(2, "====== Items ======");
		
		for item, _ in pairs( IA.Items.Stored ) do
			ply:PrintMessage(2, item);
		end;
	end;
end);