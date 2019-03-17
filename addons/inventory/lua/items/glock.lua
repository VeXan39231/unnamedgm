local ITEM = {};

ITEM.Name = "Glock"
ITEM.Info = "An ugly pistol."
ITEM.Model = "models/weapons/w_pist_glock18.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 1

function ITEM:DropItem( ply )
	ply:SpawnItem("glock");
	ply:RemoveItem("glock", 1)
end;

function ITEM:UseItem( ply )
	ply:Give("tfcss_glock");
	ply:RemoveItem("glock", 1)
end

IA.Items:RegisterItem("glock", ITEM)