--dropmoney
hook.Add( "PlayerSay", "dropmoneycmd", function( ply, txt )

	if IsValid( ply ) then
		
		if string.sub( txt, 1, 10 ) == "!dropmoney" then
			
			local amt = tonumber( string.Explode( " ", txt, false )[2] )

			if amt == nil then
				ply:ChatPrint( "You must enter a number!" )
			elseif amt > cdata.getMoney( ply ) then
				ply:ChatPrint( "You are missing $" .. amt - cdata.getMoney( ply ) .. "!" )
			else
				cdata.subMoney( ply, amt )
				local money = ents.Create( "money" )
				money:SetPos( ply:GetEyeTrace().HitPos + Vector( 0, 0, 5 ) )
				money:Spawn()
				money:SetNWInt( "amount", amt )
			end

			return ""

		end
 
	end

end )