function savePlugs()

	local plugs = {}
	local count = 0

	for k, v in pairs( ents.FindByClass( "outlet" ) ) do
		table.insert( plugs, {v:GetPos(), v:GetAngles()} )
	end

	local data = glon.encode( plugs )
	file.Write( "outlets.txt", glon.encode( plugs ) )

	print( "Saved " .. #plugs .. " outlets" )

end

function spawnPlugs()

	for k, v in pairs( ents.FindByClass( "outlet" ) ) do
		v:Remove()
	end

	local data = file.Read( "outlets.txt" )

	local plugs = glon.decode( data )
	for k, v in pairs( plugs ) do
		local ent = ents.Create( "outlet" )
		ent:SetPos( v[1] )
		ent:SetAngles( v[2] )
		ent:Spawn()
	end

	print( "Spawned " .. #plugs .. " outlets" )

end

spawnPlugs()