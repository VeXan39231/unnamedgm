local ITEM = {};

ITEM.Name = "SG-552"
ITEM.Info = "An assault rifle."
ITEM.Model = "models/weapons/w_rif_sg552.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("sg552");
	ply:RemoveItem("sg552", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_sg552");
	ply:RemoveItem("sg552", 1)
end

IA.Items:RegisterItem("sg552", ITEM)