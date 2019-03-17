local ITEM = {};

ITEM.Name = "Mask"
ITEM.Info = "Used to hide your identity."
ITEM.Model = "models/sal/halloween/ninja.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 0

function ITEM:DropItem( ply )
	ply:SpawnItem("mask");
	ply:RemoveItem("mask", 1)
end;

function ITEM:UseItem( ply )
	cdata.maskPlayer( ply )
	ply:RemoveItem("mask", 1)
end

IA.Items:RegisterItem("mask", ITEM)