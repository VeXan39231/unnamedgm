local outfit = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {
						},
						["self"] = {
							["Skin"] = 0,
							["Invert"] = false,
							["LightBlend"] = 1,
							["CellShade"] = 0,
							["OwnerName"] = "self",
							["AimPartName"] = "",
							["IgnoreZ"] = false,
							["AimPartUID"] = "",
							["Passes"] = 1,
							["Name"] = "",
							["NoTextureFiltering"] = false,
							["DoubleFace"] = false,
							["PositionOffset"] = Vector(0, 0, 0),
							["IsDisturbing"] = false,
							["Fullbright"] = false,
							["EyeAngles"] = false,
							["DrawOrder"] = 0,
							["TintColor"] = Vector(0, 0, 0),
							["UniqueID"] = "1476276391",
							["Translucent"] = false,
							["LodOverride"] = -1,
							["BlurSpacing"] = 0,
							["Alpha"] = 1,
							["Material"] = "",
							["UseWeaponColor"] = false,
							["UsePlayerColor"] = false,
							["UseLegacyScale"] = false,
							["Bone"] = "head",
							["Color"] = Vector(255, 255, 255),
							["Brightness"] = 1,
							["BoneMerge"] = false,
							["BlurLength"] = 0,
							["Position"] = Vector(1.3003387451172, 0.390625, -0.11602783203125),
							["AngleOffset"] = Angle(0, 0, 0),
							["AlternativeScaling"] = false,
							["Hide"] = false,
							["OwnerEntity"] = false,
							["Scale"] = Vector(1, 1, 1),
							["ClassName"] = "model",
							["EditorExpand"] = false,
							["Size"] = 1.1,
							["ModelFallback"] = "",
							["Angles"] = Angle(0, -90, -90),
							["TextureFilter"] = 3,
							["Model"] = "models/sal/halloween/ninja.mdl",
							["BlendMode"] = "",
						},
					},
				},
				["self"] = {
					["DrawOrder"] = 0,
					["UniqueID"] = "734064838",
					["AimPartUID"] = "",
					["Hide"] = false,
					["Duplicate"] = false,
					["ClassName"] = "group",
					["OwnerName"] = "self",
					["IsDisturbing"] = false,
					["Name"] = "my outfit",
					["EditorExpand"] = true,
				},
			},

		}

net.Receive( "plyMasked", function()
	local isMasked = net.ReadBool()
	local ent =  net.ReadEntity()
	ent:SetNWBool( "masked", isMasked )
	
	ent:ChatPrint( "Type '!mask' to take off your mask." )

	if ent == LocalPlayer() then

		hook.Add( "HUDPaint", "showMaskOverlay", function()
			if ent:GetNWBool( "masked" ) then
				surface.SetMaterial( Material( "vexan/vmask/overlay" ) )
				surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
				drawCompass()
				draw.DrawText( "You are masked", "BebasNeue", ScrW() / 2, ScrH() / 50, Color( 200, 200, 200 ), TEXT_ALIGN_CENTER )
				draw.DrawText( "Your identity is hidden", "BebasNeueSmall", ScrW() / 2, ScrH() / 13, Color( 200, 200, 200 ), TEXT_ALIGN_CENTER )
			end
		end )

	end

	pac.SetupENT( ent )
	ent:AttachPACPart( outfit )

end )

net.Receive( "plyUnMasked", function()
	local isMasked = net.ReadBool()
	local ent =  net.ReadEntity()
	ent:SetNWBool( "masked", isMasked )

	--concommand.Run( LocalPlayer(), "r_screenoverlay 0" )
	
	pac.SetupENT( ent )
	ent:RemovePACPart( outfit )

end )

hook.Add( "OnPlayerChat", "playerMaskCommands", function( ply, txt, team, dead )

	if dead then return end
	
	if IsValid( ply ) then
		if txt == "!mask" then
			net.Start( "invertMask" )
			net.SendToServer()
		end
	end

end )