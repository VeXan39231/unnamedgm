local ITEM = {};

ITEM.Name = "M4A1"
ITEM.Info = "An automatic rifle."
ITEM.Model = "models/weapons/w_rif_m4a1.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("m4a1");
	ply:RemoveItem("m4a1", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_m4a1");
	ply:RemoveItem("m4a1", 1)
end

IA.Items:RegisterItem("m4a1", ITEM)