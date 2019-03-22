entmarkers = {}

entmarkers.config = {
	ents = { "cocaine", "ia_item", "money", "outlet", "printer" },

}

local m, c = 0, 0

local healthShit = {
	{ 100, 91, hString = "Very Healthy", },
	{ 90, 81, hString = "Healthy" },
	{ 80, 71, hString = "Somewhat Healthy" },
	{ 70, 61, hString = "Hurt" },
	{ 60, 51, hString = "Somewhat Hurt" },
	{ 50, 41, hString = "Very Hurt" },
	{ 40, 31, hString = "Limping" },
	{ 30, 21, hString = "Almost Dead" },
	{ 20, 11, hString = "Dying" },
	{ 10, 1, hString = "Brink Of Death" }
}

--PrintTable( healthShit )

--print( vmath.isInBetween( 65, healthShit[4][2], healthShit[4][1] ) )

function showEntMarkers()

	local ply = LocalPlayer()
	local trace = LocalPlayer():GetEyeTrace()
	local trent = trace.Entity

	for k, v in pairs( entmarkers.config.ents ) do
		for _k, _v in pairs( ents.FindByClass( v ) ) do
			if _v == trent then
				local pos = _v:GetPos()
				local nicename = v:gsub("^%l", string.upper)

				cam.Start3D2D( pos, Angle( 0, ply:GetAngles().y - 90, 90 ), 0.065 )
				--print(v)
					if v == "cocaine" then
						draw.SimpleTextOutlined( nicename .. " (".. _v:GetNWInt( "amountLeft" ) .. "/" .. _v:GetNWInt( "originalAmount" ) .. ")", "BebasNeue", 0, -120, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 2, Color( 0, 0, 0 ) )
					elseif v == "ia_item" then
						local entName = _v:GetNWString( "ia_Name" )
						draw.SimpleTextOutlined( entName, "BebasNeue", 0, -120, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					else
						draw.SimpleTextOutlined( "", "BebasNeue", 0, -120, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					end
				cam.End3D2D()
				if v == "money" then
					cam.Start3D2D( _v:GetPos() + Vector( 0, 2, 1 ), _v:GetAngles(), 0.065 )
						draw.SimpleTextOutlined( "$" .. _v:GetNWInt( "amount" ), "BebasNeue", 0, 0, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 2, Color( 0, 0, 0 ) )
					cam.End3D2D()
				end
				if v == "outlet" then
					cam.Start3D2D( _v:GetPos() + Vector( 0, 0, 1 ), _v:GetAngles() + Angle( 0, 90, 90 ), 0.065 )
						net.Start( "getPlugInfo" )
							net.WriteEntity( _v )
						net.SendToServer()
						net.Receive( "sendPlugInfo", function()
							m, c = net.ReadInt( 32 ), net.ReadInt( 31 )
						end )
						draw.SimpleTextOutlined( "Outlet (" .. c .. "/" .. m .. ")", "BebasNeue", 0, -300, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					cam.End3D2D()
				end
				if v == "printer" then
					cam.Start3D2D( _v:GetPos(),Angle( 0, LocalPlayer():GetAngles().y - 90, 90 ), 0.065 )
						net.Start( "getPrinterInfo" )
							net.WriteEntity( _v )
						net.SendToServer()
						net.Receive( "sendPrinterInfo", function()
							mo = net.ReadInt( 32 )
						end )

					draw.SimpleTextOutlined( "Money Printer ($" .. mo .. ")", "BebasNeue", 0, -120, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					cam.End3D2D()
				end
			end
		end
	end

end

function getNiceHealth( ply )

	for i = 1, 10 do
		if vmath.isInBetween( ply:Health(), healthShit[i][2], healthShit[i][1] ) then
			return healthShit[i].hString
		end
	end

	if ply:Health() == 0 then return "Dead" end

end

function getNiceHealthColor( ply )

	local hp = ply:Health()
	local hpColorR = math.Remap( hp, 0, 100, 255, 0 )
	local hpColorG = math.Remap( hp, 0, 100, 0, 255 )
	return Color( hpColorR, hpColorG, 0 )

end

--this isn't secure lol it doesn't matter *that* much
net.Receive( "sendPlayerMaskStatus", function()
	local isMasked = net.ReadBool()
	local nigga = net.ReadEntity()
	nigga:SetNWBool( "masked", isMasked )
end )


function drawNameOverPlayer()

	for k, v in pairs( player.GetAll() ) do

		if LocalPlayer():GetEyeTrace().Entity == v then

			local a = LocalPlayer():GetPos()
			local b = LocalPlayer():GetEyeTrace().Entity:GetPos()

			if a:Distance( b ) <= 500 then

				cam.Start3D2D( v:GetPos(), Angle( 0, LocalPlayer():GetAngles().y - 90, 90 ), 0.1 )

					if v:GetNWBool( "masked" ) then
						draw.SimpleTextOutlined( "Masked Player", "BebasNeue", 0, -800, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					else
						draw.SimpleTextOutlined( v:Nick(), "BebasNeue", 0, -800, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
					end

					
					draw.SimpleTextOutlined( getNiceHealth( v ), "BebasNeue", 0, -750, getNiceHealthColor( v ), TEXT_ALIGN_CENTER, nil, 1, Color( 0, 0, 0 ) )
				cam.End3D2D()
			end
		end
	end

end

hook.Add( "PostDrawOpaqueRenderables", "showentMarkers", function() showEntMarkers() drawNameOverPlayer() end )
hook.Add( "HUDDrawTargetID", "showPlayerName", function() return false end )