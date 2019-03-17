----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

local meta = FindMetaTable( "Player" );

function meta:EyeTrace( dis )
	local tr = {};
	tr.start = self:GetShootPos();
	tr.endpos = tr.start + (self:GetAimVector() * dis);
	tr.filter = self;
	tr = util.TraceLine(tr);
	return tr;
end;

-- Config.
IA.Config = {};

IA.Config["bindF4"] = true; -- Bind F4 to open inventory menu? false will turn it off.