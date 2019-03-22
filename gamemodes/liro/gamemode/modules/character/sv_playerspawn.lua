cdata.playerSpawn = {}

cdata.playerSpawn.config = {
	defaultLoadout = { "weapon_physgun", "weapon_physcannon", "weapon_fists", "weapon_empty_hands" }
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

	cdata.playerSpawn.spawn( ply )

end

function cdata.playerSpawn.spawn( ply )

	for k, v in pairs( cdata.playerSpawn.config.defaultLoadout ) do
		ply:Give( v )
	end

	if ply:Team() == 2 then
		ply:SetModel( "models/player/urban.mdl" )
	else
		ply:SetModel( cdata.getPlayerData( ply )[1].model )
	end

	local teamColor = team.GetColor( ply:Team() )

	ply:SetPlayerColor( Vector( teamColor.r / 255, teamColor.g / 255, teamColor.b / 255 ) )

	local fedData = getFedInfo( ply:SteamID64() )
	local fedSpawn = table.Random( glon.decode( file.Read( "fedspawns.txt" ) ) )

	ply:SetWalkSpeed( 200 )
	ply:SetRunSpeed( 300 )

	if fedData then
		ply:SetPos( fedSpawn )
		ply:StripWeapons()
		ply:SetPlayerColor( Vector( 255 / 255, 100 / 255, 0 ) )
		ply:SetWalkSpeed( 125 )
		ply:SetRunSpeed( 125 )
	end

end

hook.Add( "PlayerInitialSpawn", "ccInitialSpawn", cdata.playerSpawn.setUp )
hook.Add( "PlayerSpawn", "ccSpawn", cdata.playerSpawn.spawn )