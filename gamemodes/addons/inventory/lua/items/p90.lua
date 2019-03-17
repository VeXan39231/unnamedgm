local ITEM = {};

ITEM.Name = "P90"
ITEM.Info = "A submachine gun."
ITEM.Model = "models/weapons/w_smg_p90.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("p90");
	ply:RemoveItem("p90", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_p90");
	ply:RemoveItem("p90", 1)
end

IA.Items:RegisterItem("p90", ITEM)