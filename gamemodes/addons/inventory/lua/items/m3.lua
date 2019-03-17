local ITEM = {};

ITEM.Name = "M3 Shotty"
ITEM.Info = "A pump-action shotgun."
ITEM.Model = "models/weapons/w_shot_m3super90.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("m3");
	ply:RemoveItem("m3", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_m3");
	ply:RemoveItem("m3", 1)
end

IA.Items:RegisterItem("m3", ITEM)