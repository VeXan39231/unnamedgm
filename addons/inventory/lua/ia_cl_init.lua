----------------------
-- InventoryAddon 2 --
-- Author: Chewgum	--
----------------------

IA = {};

include("ia_shared.lua");
include("ia_items.lua");

hook.Add("Initialize", "ia_createFont", function()
	surface.CreateFont("ia_itemFont", { "coolvetica", 24, 500, true, false } );
end);

local color_black = Color(0, 0, 0, 255);
local InventoryOpen = false;
local InventoryFrame = nil;
local Inventory = {};

local function ToggleMenu()
	InventoryOpen = !InventoryOpen;
	gui.EnableScreenClicker(InventoryOpen);
	InventoryFrame:SetVisible(InventoryOpen);
end;

usermessage.Hook("ia_giveItem", function( um )
	local item = um:ReadString();
	local amount = um:ReadLong();
	
	if (Inventory[item]) then
		Inventory[item] = Inventory[item] + amount;
	else
		Inventory[item] = 0;
		Inventory[item] = Inventory[item] + amount;
	end;
end);

usermessage.Hook("ia_removeItem", function( um )
	local item = um:ReadString();
	local amount = um:ReadLong();
	
	if (amount == 0) then
		Inventory[item] = nil;
		return;
	end;
	
	Inventory[item] = amount;
end);

usermessage.Hook("ia_savedItems", function( um )
	local item = um:ReadString();
	local amount = um:ReadLong();
	
	Inventory[item] = 0;
	Inventory[item] = Inventory[item] + amount;
end);

local PANEL = {};

function PANEL:Init()
	self:SetSize(468, 400);
	self:Center();
	self:SetTitle( LocalPlayer():Nick() .. "'s Inventory"  );
	self:ShowCloseButton(false);
	
	self.panelList = vgui.Create("DPanelList", self);
	self.panelList:SetPos(3, 25);
	self.panelList:SetSize(self:GetWide() - 6, self:GetTall() - 28);
	self.panelList:SetSpacing(2);
	self.panelList:SetPadding(4);
	self.panelList:EnableVerticalScrollbar(true);
	self.panelList:EnableHorizontal(true);
end;

function PANEL:Update()
	if (self.panelList:GetItems() != nil) then
		self.panelList:Clear();
	end;
	
	local items = 0

	for k, v in pairs(Inventory) do
		local itemTable = IA.Items:GetItem(k);
		
		-- Credits to Gofish v2 for this, shitty method though :S, might redo..
		local entFilthyHack = ents.CreateClientProp("prop_physics");
		entFilthyHack:SetAngles(Angle( 0, 0, 0 ));
		entFilthyHack:SetPos(Vector( 0, 0, 0 ));
		entFilthyHack:SetModel(itemTable.Model);
		entFilthyHack:Spawn();
		
		local bgCol = Color(10, 10, 10, 255);
		local backgroundPanel = vgui.Create("DPanel");
		backgroundPanel:SetSize(55, 55);
		backgroundPanel.Paint = function()
			draw.RoundedBox(6, 0, 0, backgroundPanel:GetWide(), backgroundPanel:GetTall(), bgCol);
			draw.RoundedBox(6, 1, 1, backgroundPanel:GetWide() - 2, backgroundPanel:GetTall() - 2, Color(96, 96, 96, 255));
			draw.SimpleTextOutlined( v, "BebasNeueTiny", 2, 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, nil, 1, Color( 0, 0, 0 ) )
		end;
	
		local Icon = vgui.Create("DModelPanel", backgroundPanel);
		Icon:SetAnimated( false )
		Icon:SetSize(55, 55);
		Icon:SetModel(itemTable.Model);
		Icon:SetToolTip("Name: " .. itemTable.Name .. "\nInfo: " .. itemTable.Info .. "\nCount: " .. v);
		local items = items + 1
		
		local entCenter = entFilthyHack:OBBCenter();
		local entDist = entFilthyHack:BoundingRadius() * 1.2;
		
		Icon:SetLookAt(entCenter + Vector( 0, 0, 0 ) );
		Icon:SetCamPos(entCenter + Vector(entDist, entDist, entDist));
		
		self:SetTitle( LocalPlayer():Nick() .. "'s Inventory"  );

		Icon.DoClick = function()
			local Menu = DermaMenu();

				if (itemTable.useAble == 1) then
					Menu:AddOption("Use", function() LocalPlayer():ConCommand("ia_item_use " .. k) ToggleMenu(); end):SetIcon( "icon16/accept.png" )
				end;

				if (itemTable.dropAble == 1) then
					Menu:AddOption("Drop", function() LocalPlayer():ConCommand("ia_item_drop " .. k) ToggleMenu(); end):SetIcon( "icon16/delete.png" )
				end;

				if (itemTable.isWeapon == 1) then
					Menu:AddOption("Get Ammo (Deletes Item)", function() LocalPlayer():ConCommand("ia_item_getammo " .. k) ToggleMenu(); end):SetIcon( "icon16/gun.png" )
				end;
			Menu:Open();
		end;
		
		Icon.OnCursorEntered = function()
			function self:LayoutEntity( ent )
				return true
			end
			bgCol = Color(255, 255, 255, 255);
		end;
		
		Icon.OnCursorExited = function()
			function self:LayoutEntity( ent )

			end
			bgCol = Color(10, 10, 10, 255);
		end;
		
		entFilthyHack:Remove();
		
		self.panelList:AddItem(backgroundPanel);
	end;
end;
vgui.Register("ia_inventory", PANEL, "DFrame");

concommand.Add("ia_inventory", function( um )
	if (!InventoryFrame or !InventoryFrame:IsValid()) then
		InventoryFrame = vgui.Create("ia_inventory");
		InventoryFrame:Update();
	else
		InventoryFrame:Update();
	end;
	
	ToggleMenu();
end);



--[[
hook.Add("HUDPaint", "IA_itemName", function()
	local tr = LocalPlayer():EyeTrace(100);
	
	if (tr.Entity:IsValid() and tr.Entity:GetClass() == "ia_item") then
		local entName = tr.Entity:GetNetworkedString("ia_Name");
		local entPos =  tr.Entity:GetPos():ToScreen();
		
		draw.DrawText(entName, "ia_itemFont", entPos.x + 2, entPos.y + 22, color_black, 1);
		draw.DrawText(entName, "ia_itemFont", entPos.x, entPos.y + 20, color_white, 1);
	end;
end);
]]--