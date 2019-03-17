hook.Add( "ScalePlayerDamage", "instantHeadshots", function( ply, hit, info )

	if hit == HITGROUP_HEAD then
		
		local hitsLeft = cdata.getHitsLeft( ply )

		print( hitsLeft )

		if hitsLeft < 0 then
			cdata.setPlyHelmet( ply, false )
			info:ScaleDamage( 1000 )
		else
			info:ScaleDamage( 0.125 )
			if hitsLeft == 0 then
				cdata.setPlyHelmet( ply, false )
			end
			cdata.setHitsLeft( ply, hitsLeft - 1 )
		end

	end	

end )

hook.Add( "PlayerDeath", "removeHelmetOD", function( vic, inf, att )

	cdata.setHitsLeft( vic, 0 )
	cdata.setPlyHelmet( vic, false )

end )