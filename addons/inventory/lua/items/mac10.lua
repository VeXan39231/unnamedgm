local ITEM = {};

ITEM.Name = "Mac-10"
ITEM.Info = "A submachine gun."
ITEM.Model = "models/weapons/w_smg_mac10.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("mac10");
	ply:RemoveItem("mac10", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_mac10");
	ply:RemoveItem("mac10", 1)
end

IA.Items:RegisterItem("mac10", ITEM)