local helmet = {
	[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Skin"] = 7,
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
				["UniqueID"] = "3362760498",
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
				["Position"] = Vector(3.1752395629883, 0.00177001953125, 0.000396728515625),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = false,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(0, -90, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/dean/gtaiv/helmet.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "3673829419",
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

for k, v in pairs( player.GetAll() ) do
	
	pac.SetupENT( v )

	net.Start( "getPlyHelmet" )
	net.WriteEntity( v )
	net.SendToServer()

	net.Receive( "setPlyHelmet", function()

		local ent = net.ReadEntity()
		local hel = net.ReadBool()

		print( ent, hel )

		if hel then
			v:AttachPACPart( helmet )
		else
			v:RemovePACPart( helmet )
		end

	end )

	if v:Health() < 1 then
		v:RemovePACPart( helmet )
	end

end