cdata.playerSpawn = {}

cdata.playerSpawn.config = {
	defaultLoadout = { "weapon_fists", "weapon_empty_hands" }
	--policeLoadout = { "" }
}

function cdata.playerSpawn.setUp( ply )

	local data = cdata.getPlayerData( ply )

	if !data or data == nil then
		print("[CData] Player data missing for " .. ply:Nick() .. "\n[CData] Inserting default data" )
		local insert = cdata.insertDefaultData( ply )
		if !insert or insert == nil then
			print( "[CData] Problem insert default data" )
		else
			print( "[CData] Default data added" )
		end
	end

	local data = cdata.getPlayerData( ply )
	ply:SetModel( data[1].model )
	ply:SetTeam( 1 )

	--cdata.playerSpawn.spawn( ply )

end

function cdata.playerSpawn.spawn( ply )

	for k, v in pairs( cdata.playerSpawn.config.defaultLoadout ) do
		ply:Give( v )
	end

	if ply:Team() == 2 then
		ply:SetModel( "models/player/urban.mdl" )
	elseif ply:Team() == 0 then
		ply:SetModel( "models/food/hotdog.mdl" )
	else
		ply:SetModel( cdata.getPlayerData( ply )[1].model )
	end

	local teamColor = team.GetColor( ply:Team() )

	ply:SetPlayerColor( Vector( teamColor.r / 255, teamColor.g / 255, teamColor.b / 255 ) )

end

hook.Add( "PlayerInitialSpawn", "ccInitialSpawn", cdata.playerSpawn.setUp )
hook.Add( "PlayerSpawn", "ccSpawn", cdata.playerSpawn.spawn )