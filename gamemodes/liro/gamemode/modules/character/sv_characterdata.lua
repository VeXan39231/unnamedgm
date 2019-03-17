if SERVER then
util.AddNetworkString( "invertMask" )
util.AddNetworkString( "plyMasked" )
util.AddNetworkString( "plyUnMasked" )
util.AddNetworkString( "getPlyHelmet" )
util.AddNetworkString( "sendPlyHelmet" )
util.AddNetworkString( "setPlyHelmet" )
end

cdata = {}

cdata.config = {
	
}

function cdata.insertDefaultData( ply )

	local id64 = ply:SteamID64()
	local name = ply:Nick()
	local money = 0
	local model = "models/player/Group01/male_0" .. math.random( 1, 9 ) .. ".mdl"

	local query = sql.Query( "INSERT INTO _playerdata (id64, name, money, model) VALUES ('" .. id64 .. "', '" .. name .. "', '" .. money .. "', '" .. model .. "')" )
	local query = sql.Query( "SELECT * FROM _playerdata WHERE id64='" .. id64 .. "'" )

	if query != false and query != nil then
		print( "[CData] Sucessfully added default character data" )
		return true
	else
		print( "[CData] Problem adding default character data" )
		return false
	end

end

function cdata.resetPlayerData( ply )

	print("yeezus")

end

function cdata.setPlayerData( ply, dataType, info )

	if !IsValid( ply ) then
		print( "[CData] Failed to set data for " .. ply:Nick() .. " - Invalid Player" )
	end

	local id64 = ply:SteamID64()

	if dataType == "name" then
		if type(dataType) != "string" then
			print( "[CData] Failed to set data for " .. ply:Nick() .. " - Name must be a string" )
		else
			local query = sql.Query( "UPDATE _playerdata SET name='" .. info .. "' WHERE id64 ='" .. id64 .."'" )
			if query or query == nil then
				print( "[CData] Successfully changed name of " .. ply:Nick() )
				hook.Run( "PlayerDataModified", ply )
			else
				print( "[CData] Something went wrong when changing name of " .. ply:Nick() )
			end
		end
	elseif dataType == "money" then
		local query = sql.Query( "UPDATE _playerdata SET money='" .. info .. "' WHERE id64 ='" .. id64 .."'" )
		if query or query == nil then
			print( "[CData] Sucessfully changed money of " .. ply:Nick() )
			hook.Run( "PlayerDataModified", ply )
		else
			print( "[CData] Something went wrong when changing money of " .. ply:Nick() )
		end
	elseif dataType == "model" then
		if type(dataType) != "string" then
			print( "[CData] Failed to set data for " .. ply:Nick() .. " - Model must be a string" )
		else
			local query = sql.Query( "UPDATE _playerdata SET model='" .. info .. "' WHERE id64 ='" .. id64 .."'" )
			if query or query == nil then
				print( "[CData] Sucessfully changed model of " .. ply:Nick() )
				hook.Run( "PlayerDataModified", ply )
			else
				print( "[CData] Something went wrong when changing model of " .. ply:Nick() )
			end
		end
	end

end

function cdata.updatePlayerModel( ply )

	local id64 = ply:SteamID64()
	local data = cdata.getPlayerData( ply )

	if ply:GetModel() != data[1].model then
		ply:SetModel( data[1].model )
	end

end
hook.Add( "PlayerDataModified", "cdataUpdatePlayerModel", cdata.updatePlayerModel )

function cdata.getPlayerData( ply )

	local id64 = ply:SteamID64()
	local query = sql.Query( "SELECT * FROM _playerdata WHERE id64='" .. id64 .. "'" )

	return query

end

function cdata.isPlayerMasked( ply )

	return ply:GetNWBool( "masked" )

end



function cdata.maskPlayer( ply )

	if not cdata.isPlayerMasked( ply ) then
		ply:SetNWBool( "masked", true )
		net.Start( "plyMasked" )
			net.WriteBool( false )
			net.WriteEntity( ply )
		net.Broadcast()
	end

end

function cdata.unMaskPlayer( ply )

	if cdata.isPlayerMasked( ply ) then
		ply:SetNWBool( "masked", false )
		net.Start( "plyUnMasked" )
			net.WriteBool( false )
			net.WriteEntity( ply )
		net.Broadcast()
	end

end

net.Receive( "invertMask", function( len, ply )

	if cdata.isPlayerMasked( ply ) then
		cdata.unMaskPlayer( ply )
		ply:GiveItem( "mask" )
	else
		if ply:HasItem( "mask" ) then
			cdata.maskPlayer( ply )
			ply:RemoveItem( "mask" )
		else
			ply:ChatPrint( "You need a mask in your inventory!" )
		end
	end

end )

function cdata.setPlyHelmet( ply, bool )

		ply:SetNWBool( "helmet", bool )
		if bool then
			ply:SetNWInt( "hitsLeft", 2 )
		else
			ply:SetNWInt( "hitsLeft", 0 )
		end
		net.Start( "setPlyHelmet" )
			net.WriteEntity( ply )
			net.WriteBool( bool )
		net.Broadcast()

end

function cdata.getPlyHelmet( ply )

	return ply:GetNWInt( "helmet" )

end

function cdata.setHitsLeft( ply, amt )

	ply:SetNWInt( "hitsLeft", amt )

end

function cdata.getHitsLeft( ply )

	return ply:GetNWInt( "hitsLeft" )

end

net.Receive( "getPlyHelmet", function()

	local ply = net.ReadEntity()

	net.Start( "sendPlyHelmet" )
		net.WriteEntity( ply )
		net.WriteBool( ply:GetNWBool( "helmet" ) )
	net.Broadcast()

end )