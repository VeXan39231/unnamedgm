local ITEM = {};

ITEM.Name = "Famas"
ITEM.Info = "A bullpup rifle."
ITEM.Model = "models/weapons/w_rif_famas.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("famas");
	ply:RemoveItem("famas", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_famas");
	ply:RemoveItem("famas", 1)
end

IA.Items:RegisterItem("famas", ITEM)