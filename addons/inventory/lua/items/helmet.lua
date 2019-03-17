local ITEM = {};

ITEM.Name = "Helmet"
ITEM.Info = "Prevents instant headshot kills."
ITEM.Model = "models/dean/gtaiv/helmet.mdl"
ITEM.useAble = 1
ITEM.dropAble = 1
ITEM.isWeapon = 0

function ITEM:DropItem( ply )
	ply:SpawnItem("helmet");
	ply:RemoveItem("helmet", 1)
end;

function ITEM:UseItem( ply )
	cdata.setPlyHelmet( ply, true )
	ply:RemoveItem("helmet", 1)
end

IA.Items:RegisterItem("helmet", ITEM)