if ( SERVER ) then

	util.AddNetworkString( "hschats" )

	--HOOKS
	hook.Add( "PlayerConnect", "hschats_join", function( name, ip )

		SendChat( player.GetAll(), name .. " has connected to the server.", false )

	end )

	--FUNCS
	function SendChat( ply, txt, anno )
		if not prefix then prefix = "[HS] " end

		for k, v in pairs( player.GetAll() ) do
			if v == ply then
				net.Start( "hschats" )
					net.WriteString( txt )
					net.WriteBool( anno )
				net.Send( v )
			end
		end	

	end

else

	local annos = {}

	function showAnno( txt )

		local panel = vgui.Create( "DNotify" )
		panel:SetPos( 3	, ScrH() / 32 + ( #annos * 40 ) )
		panel:SetSize( ScrW(), 40 )
		panel:SetLife( 5 )

		local fill = vgui.Create( "DPanel", panel )
		fill:SetSize( ScrW(), 40 )

		table.insert( annos, panel )

		timer.Simple( 5, function()
			table.RemoveByValue( annos, panel )
		end )

		function fill:Paint( w, h )

			--surface.SetDrawColor( Color( 50, 50, 50, 50 ) )
			--surface.DrawRect( 0, 0, w, h )
			draw.SimpleTextOutlined( txt, "BebasNeueMed", 0, 0, Color( 255, 255, 255 ), nil, nil, 1, Color( 0, 0, 0 ) )

		end

		panel:AddItem( fill )

		surface.PlaySound( "buttons/blip1.wav" )

	end

	function showChat( txt )

		chat.AddText( Color( 0, 150, 255 ), "[HS] ", Color( 255, 255, 255 ), txt )

	end

	net.Receive( "hschats", function()
		print("Gotem")
		local txt = net.ReadString()
		local anno = net.ReadBool()

		if anno then
			showAnno( txt )
		else
			showChat( txt )
		end

	end )

end

