local ITEM = {};

ITEM.Name = "AUG"
ITEM.Info = "A bullpup rifle."
ITEM.Model = "models/weapons/w_rif_aug.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("aug");
	ply:RemoveItem("aug", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_aug");
	ply:RemoveItem("aug", 1)
end

IA.Items:RegisterItem("aug", ITEM)