local ITEM = {};

ITEM.Name = "P228"
ITEM.Info = "A pistol."
ITEM.Model = "models/weapons/w_pist_p228.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("p228");
	ply:RemoveItem("p228", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_p228");
	ply:RemoveItem("p228", 1)
end

IA.Items:RegisterItem("p228", ITEM)