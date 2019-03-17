local ITEM = {};

ITEM.Name = "MP5 Navy"
ITEM.Info = "A submachine gun."
ITEM.Model = "models/weapons/w_smg_mp5.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("mp5");
	ply:RemoveItem("mp5", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_mp5");
	ply:RemoveItem("mp5", 1)
end

IA.Items:RegisterItem("mp5", ITEM)