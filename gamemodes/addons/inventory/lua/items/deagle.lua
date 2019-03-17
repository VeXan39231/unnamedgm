local ITEM = {};

ITEM.Name = "Desert Eagle"
ITEM.Info = "A .50 pistol."
ITEM.Model = "models/weapons/w_pist_deagle.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("deagle");
	ply:RemoveItem("deagle", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_deagle");
	ply:RemoveItem("deagle", 1)
end

IA.Items:RegisterItem("deagle", ITEM)