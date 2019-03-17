teams = {}

teams.config = {}

team.SetUp( 0, "Spectators", Color( 150, 150, 150 ) )
team.SetUp( 1, "Citizens", Color( 50, 200, 50 ) )
team.SetUp( 2, "Police", Color( 50, 50, 200 ) )

function teams.flipTeam( ply )

	if ply:Team() == 0 then
		ply:SetTeam( 1 )
	elseif ply:Team() == 1 then
		ply:SetTeam( 2 )
	else
		ply:SetTeam( 1 )
	end

	ply:Spawn()

end

concommand.Add( "flip_teams", function( ply ) teams.flipTeam( ply ) end )	