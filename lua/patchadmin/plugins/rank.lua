local Plugin = {
	
	name = "Rank",
	command = "rank",
	alias = {},
	args_required = { "PLAYER_1", "rank" },
	args_optional = {}

}

-- RANK A PLAYER
function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	local rank = args["rank"]
	local teams = team.GetAllTeams()
	local curteam = pl:Team()

	-- Check current rank
	if rank == teams[curteam].Name or string.lower( rank ) == string.lower( teams[curteam].Name ) then
		sv_PAdmin.notify( ply, "lightblue", pl:Nick(), "white", " is already a ", team.GetColor( pl:Team() ), team.GetName( pl:Team() ), "white", "!" )
		return
	end

	-- Search rank
	local index = -1
	table.foreach( teams, function( id, team )
		if rank == team.Name or string.lower( rank ) == string.lower( team.Name ) then
			index = id
		end
	end )

	-- Check rank
	if index == -1 then
		sv_PAdmin.notify( ply, "white", "'", "red", rank, "white", "' is not a valid rank!" )
		return
	end

	-- Rank player
	pl:SetTeam( index )
	pl:SetUserGroup( teams[index].Usergroup )

	-- Save new rank
	if sql.Query( "SELECT rid FROM padmin_player_ranks WHERE uid = " .. pl:UniqueID() ) then
		sql.Query( "UPDATE padmin_player_ranks SET rid = '" .. index .. "' WHERE uid = " .. pl:UniqueID() )
	else
		sql.Query( "INSERT INTO padmin_player_ranks( 'uid', 'rid' ) VALUES( '" .. pl:UniqueID() .. "', '" .. index .. "')" )
	end

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " ranked ", "lightblue", pl:Nick(), "white", " to a ", team.GetColor( pl:Team() ), team.GetName( pl:Team() ) )

end

sv_PAdmin.AddPlugin( Plugin )
