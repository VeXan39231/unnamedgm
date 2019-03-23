local CATEGORY_NAME = "Liro"

function ulx.federal( calling_ply, target_ply, time, reason )

	if reason == "" then
		local reason = "No reason given"
	end

	for k, v in pairs( target_ply ) do
		if not isFed( v ) then
			grantFed( v, time, reason, calling_ply )
		end
	end

end

local federal = ulx.command( CATEGORY_NAME, "ulx federal", ulx.federal, "!federal" )
federal:defaultAccess( ULib.ACCESS_SUPERADMIN )
federal:addParam{ type=ULib.cmds.PlayersArg }
federal:addParam{ type=ULib.cmds.NumArg, min=1, max=604800, default=60, hint="time", ULib.cmds.round }
federal:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine }