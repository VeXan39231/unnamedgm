local ITEM = {};

ITEM.Name = "Dual Elites"
ITEM.Info = "2 pistols."
ITEM.Model = "models/weapons/w_pist_elite.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("dualelites");
	ply:RemoveItem("dualelites", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_elite");
	ply:RemoveItem("dualelites", 1)
end

IA.Items:RegisterItem("dualelites", ITEM)