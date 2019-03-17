local ITEM = {};

ITEM.Name = "M249 Para"
ITEM.Info = "A machine gun."
ITEM.Model = "models/weapons/w_mach_m249para.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("m249");
	ply:RemoveItem("m249", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_m249");
	ply:RemoveItem("m249", 1)
end

IA.Items:RegisterItem("m249", ITEM)