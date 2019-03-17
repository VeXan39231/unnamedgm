hook.Add( "PlayerCanPickupItem", "disableWeaponPickup", function( ply, wep )
	if ( ply:HasWeapon( wep:GetClass() ) ) then return false end
end )
