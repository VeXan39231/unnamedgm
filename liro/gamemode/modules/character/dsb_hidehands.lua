-- Quick fix for a revolver showing up as the player's weapon when hands are out.
for k, v in pairs( player.GetAll() ) do
	if v:GetActiveWeapon():GetClass() == "weapon_empty_hands" then
		v:DrawWorldModel( false )
	end
end