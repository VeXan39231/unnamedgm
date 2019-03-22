--hook.Remove( "HUDPaint", "fedHUDXD" )
hook.Add( "Think", "like20feet", function()
	net.Start( "getFederal" )
	net.SendToServer()
end )

net.Receive( "sendFederal", function()

	local data = net.ReadTable()
	local nicet = string.FormattedTime( data.time )
	local nicett = nicet.h .. " hours, " .. nicet.m .. " minutes, " .. nicet.s .. " seconds"

	hook.Add( "HUDPaint", "fedHUDXD", function()
		
			function showShit()
				draw.SimpleTextOutlined( "You are in Federal Prison", "BebasNeue", ScrW() / 2, ScrH() / 50, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 2, Color( 0, 0, 0 ) )
				draw.SimpleTextOutlined( "Time Left: " .. nicett , "BebasNeueMed", ScrW() / 2, ScrH() / 14, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 2, Color( 0, 0, 0 ) )
			end

		showShit()

	end )

end )

net.Receive( "endFederal", function()

	hook.Remove( "HUDPaint", "fedHUDXD" )

end )
