local ITEM = {};

ITEM.Name = "UMP-45"
ITEM.Info = "A submachine gun."
ITEM.Model = "models/weapons/w_smg_ump45.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("ump45");
	ply:RemoveItem("ump45", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_ump45");
	ply:RemoveItem("ump45", 1)
end

IA.Items:RegisterItem("ump45", ITEM)