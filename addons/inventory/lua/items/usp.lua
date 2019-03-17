local ITEM = {};

ITEM.Name = "USP"
ITEM.Info = "A pistol."
ITEM.Model = "models/weapons/w_pist_usp.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("usp");
	ply:RemoveItem("usp", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_usp");
	ply:RemoveItem("usp", 1)
end

IA.Items:RegisterItem("usp", ITEM)