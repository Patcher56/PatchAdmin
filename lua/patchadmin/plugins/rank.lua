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

	if rank == "superadmin" or rank == "admin" then

		pl:SetUserGroup( rank )

		local check_rank = sql.Query( "SELECT rank FROM padmin_ranks WHERE uniqueid = " .. pl:UniqueID() )
		if check_rank != nil and check_rank != false then
			sql.Query( "UPDATE padmin_ranks SET 'rank' = '" .. pl:GetUserGroup() .. "' WHERE uniqueid = " .. pl:UniqueID() )
		else
			sql.Query( "INSERT INTO padmin_ranks( 'uniqueid', 'rank' ) VALUES( '" .. pl:UniqueID() .. "', '" .. pl:GetUserGroup() .. "')" )
		end

	end

	sv_PAdmin.notify( nil, { "lightblue", ply:Nick(), "white", " ranked ", "lightblue", pl:Nick(), "white", " to a ", "red", rank } )

end

-- SET RANK IF A PLAYER JOINS THE SERVER
function sv_PAdmin.SetupRanks( ply )

	local rank = sql.QueryRow( "SELECT rank FROM padmin_ranks WHERE uniqueid = " .. ply:UniqueID() )

	if rank == nil or rank == false then return end

	if ply:GetUserGroup() != rank["rank"] then ply:SetUserGroup( rank["rank"] ) end

end
hook.Add( "PlayerInitialSpawn", "padmin_setupranks", sv_PAdmin.SetupRanks )

sv_PAdmin.AddPlugin( Plugin )
