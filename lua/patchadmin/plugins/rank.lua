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
	if rank == pl:GetUserGroup() then return end

	local teams = team.GetAllTeams()

	local index = -1
	table.foreach( teams, function( id, team )

		if rank == team.Name then
			index = id
		end

	end )

	if index == -1 then

		sv_PAdmin.notify( nil, "red", rank, "white", " is not a valid rank!" )
		return

	end

	pl:SetTeam( index )
	pl:SetUserGroup( teams[index].Usergroup )

	if sql.Query( "SELECT rid FROM padmin_player_ranks WHERE uid = " .. pl:UniqueID() ) then

		sql.Query( "UPDATE padmin_player_ranks SET rid = '" .. index .. "' WHERE uid = " .. pl:UniqueID() )

	else

		sql.Query( "INSERT INTO padmin_player_ranks( 'uid', 'rid' ) VALUES( '" .. pl:UniqueID() .. "', '" .. index .. "')" )

	end

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " ranked ", "lightblue", pl:Nick(), "white", " to a ", teams[index].Color, teams[index].Alias )

end

sv_PAdmin.AddPlugin( Plugin )
