local ITEM = {};

ITEM.Name = "TMP"
ITEM.Info = "A submachine gun."
ITEM.Model = "models/weapons/w_smg_tmp.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("tmp");
	ply:RemoveItem("tmp", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_tmp");
	ply:RemoveItem("tmp", 1)
end

IA.Items:RegisterItem("tmp", ITEM)