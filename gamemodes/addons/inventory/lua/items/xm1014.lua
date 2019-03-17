local ITEM = {};

ITEM.Name = "XM1014"
ITEM.Info = "A semi-automatic shotgun."
ITEM.Model = "models/weapons/w_shot_xm1014.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("xm1014");
	ply:RemoveItem("xm1014", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_xm1014");
	ply:RemoveItem("xm1014", 1)
end

IA.Items:RegisterItem("xm1014", ITEM)