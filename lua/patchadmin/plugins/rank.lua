local Plugin = {
	
	name = "Rank",
	command = "rank",
	alias = {},
	args_required = { "PLAYER_1", "rank" },
	args_optional = {}

}

-- RANK A PLAYER
function Plugin:Call( ply, args )

	local pl = args.PLAYER_1
	local rank = args.rank
	local teams = team.GetAllTeams()

	-- Check current rank
	if string.lower( rank ) == string.lower( teams[pl:Team()].Name ) then
		sv_PAdmin.notify( ply, "lightblue", pl:Nick(), "white", " is already a ", team.GetColor( pl:Team() ), team.GetName( pl:Team() ), "white", "!" )
		return
	end

	-- Search rank
	local index = nil
	table.foreach( teams, function( id, team )
		if string.lower( rank ) == string.lower( team.Name ) then
			index = id
		end
	end )

	-- Check rank
	if !index then
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

local PLAYER = FindMetaTable( "Player" )
function PLAYER:GetRank()

	return team.GetName( self:Team() ), team.GetColor( self:Team() )

end

sv_PAdmin.addPlugin( Plugin )
