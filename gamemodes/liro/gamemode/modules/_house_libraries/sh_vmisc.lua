function showOffHP( ply )

	ply:SetHealth( 100 )

	timer.Create( "showOffHPTimer", 0.1, 100, function()
		ply:SetHealth( ply:Health() - 1 )
	end )

end