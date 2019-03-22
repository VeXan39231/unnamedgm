util.AddNetworkString( "getFederal" )
util.AddNetworkString( "sendFederal" )
util.AddNetworkString( "endFederal" )

function freshFeds()
	local yert = { Vector( 0, 0, 0 ) }
	file.Write( "fedspawns.txt", glon.encode(yert) )
end

function addFedSpawn( pos )

	local sptbl = glon.decode( file.Read( "fedspawns.txt" ) )

	table.insert( sptbl, pos )

	file.Write( "fedspawns.txt", glon.encode( sptbl ) )

end

function getFedSpawns()

	return glon.decode( file.Read( "fedspawns.txt" ) )

end

function grantFed( ply, time, reason, admin )

	local query = sql.Query( "INSERT INTO _feddata (id64, time, reason, admin) VALUES ('" .. ply:SteamID64() .. "', '" .. time .. "', '" .. reason .. "', '" .. admin:Nick() .. "')" )

	if query == nil then
		print( admin:Nick() .. " sent " .. ply:Nick() .. " to Federal for " .. time .. " seconds for: '" .. reason .. "'" )
		ply:Spawn()
		fedClock()

		SendChat( ply, "You have been sent to Federal", true )
		SendChat( ply, "Sender: " .. admin:Nick(), true )
		SendChat( ply, "Reason: " .. reason, true )

		for k, v in pairs( player.GetAll() ) do
			
			if v != ply then

			SendChat( v, ply:Nick() .. " has been sent to Federal", true )
			SendChat( v, "Sender: " .. admin:Nick(), true )
			SendChat( v, "Reason: " .. reason, true )

			end

		end

	end

end

function setFedTime( id64, time )

	sql.Query( "UPDATE _feddata SET time = '" .. time .. "' WHERE id64 = '" .. id64 .. "'" )

	fedClock()

end

function getFedInfo( id64 )

	local query = sql.Query( "SELECT * FROM _feddata WHERE id64 = '" .. id64 .. "'" )

	if query then
		return query[1]
	end

end

function isFed( ply )

	local id64 = ply:SteamID64()

	local query = sql.Query( "SELECT * FROM _feddata WHERE id64 = '" .. id64 .. "'" )

	if query == nil then
		return false
	else
		return true
	end

end

net.Receive( "getFederal", function( len, ply )

	--PrintTable( getFedInfo( ply:SteamID64() ) )

	if isFed( ply ) then
		net.Start( "sendFederal" )
			net.WriteTable( getFedInfo( ply:SteamID64() ) )
		net.Broadcast()
	else
		net.Start( "endFederal" )
		net.Broadcast()
	end

end )

function fedClock()

	local query = sql.Query( "SELECT * FROM _feddata" )

	if query then
		for k, v in pairs( query ) do
			timer.Create( "fedClock" .. v.id64, 1, 0, function()
				local yert = v.time - 1

				if tonumber( v.time ) < 1 then
					sql.Query( "DELETE FROM _feddata WHERE id64 = '" .. v.id64 .. "'" )
					hook.Run( "PlyReleasedFromFed", v.id64 )
					timer.Destroy( "fedClock" .. v.id64 )
					if IsValid( player.GetBySteamID64( v.id64 ) ) then
						player.GetBySteamID64( v.id64 ):Spawn()
					end
				else
					sql.Query( "UPDATE _feddata SET time = '" .. yert .. "' WHERE id64 = '" .. v.id64 .. "'" )
					fedClock()
					--print( v.time )
				end

			end )
		end
	end

end

fedClock()

hook.Add( "PlyReleasedFromFed", "yertt", function( id64 )

	print( id64 .. " released from Federal" )

	if IsValid( player.GetBySteamID64( id64 ) ) then
		SendChat( player.GetBySteamID64( id64 ), "You have been released from Federal.", true )
	end

end )

hook.Add( "PlayerSay", "federalcmds", function( ply, txt, team )

	if txt == "!addfedspawn" then
		if ply:IsAdmin() then
			addFedSpawn( ply:GetPos() + Vector( 0, 0, 2 ) )
			ply:ChatPrint( "Added Federal Spawnpoint" )
		else
			ply:ChatPrint( "You must be an Administrator to use this command." )
		end
		return ""
	end

end )