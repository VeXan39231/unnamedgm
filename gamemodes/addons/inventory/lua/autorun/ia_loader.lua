----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

-- Enable or disable the addon.
-- 'false' will turn it off.
local InventoryAddonEnabled = true;

if (!InventoryAddonEnabled) then print("Inventory Addon is disabled")
	return;
end;

if ( SERVER ) then
	include("ia_init.lua");
	
	--Credit goes to the makers of Wire mod.
	local tags = string.Explode(",", ( GetConVarString( "sv_tags" ) or "" ));
	
	for i, tag in ipairs(tags) do
		if (tag:find( "InventoryAddon" )) then
			table.remove(tags, i);
		end;
	end;
	
	table.insert(tags, "InventoryAddon");
	table.sort(tags);
	
	RunConsoleCommand("sv_tags", table.concat( tags, "," ));
else
	include("ia_cl_init.lua");
end;