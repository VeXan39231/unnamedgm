local ITEM = {};

ITEM.Name = "AK47"
ITEM.Info = "An assault rifle."
ITEM.Model = "models/weapons/w_rif_ak47.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("ak47");
	ply:RemoveItem("ak47", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_ak47");
	ply:RemoveItem("ak47", 1)
end

IA.Items:RegisterItem("ak47", ITEM)