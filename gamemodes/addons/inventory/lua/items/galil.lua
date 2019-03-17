local ITEM = {};

ITEM.Name = "Galil"
ITEM.Info = "An ugly assault rifle."
ITEM.Model = "models/weapons/w_rif_galil.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("galil");
	ply:RemoveItem("galil", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_galil");
	ply:RemoveItem("galil", 1)
end

IA.Items:RegisterItem("galil", ITEM)