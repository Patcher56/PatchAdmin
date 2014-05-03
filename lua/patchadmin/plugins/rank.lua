local Plugin = {
	
	name = "Rank",
	command = "rank",
	args_required = { "player", "rank" },
	args_optional = { "test", "test2" }

}

function Plugin:Call( ply, args )

	PrintTable(args)

	local pl = args["player"]

	if args["rank"] == pl:GetUserGroup() then return end

	if args["rank"] == "superadmin" or args["rank"] == "admin" then

		pl:SetUserGroup(args["rank"])

		local ranks = sql.Query( "SELECT rank FROM padmin_ranks WHERE uniqueid = " .. pl:UniqueID() )

		if ranks != nil and ranks != false then

			sql.Query( "UPDATE padmin_ranks SET 'rank' = '" .. pl:GetUserGroup() .. "' WHERE uniqueid = " .. pl:UniqueID() )

		else
		
			sql.Query( "INSERT INTO padmin_ranks( 'uniqueid', 'rank' ) VALUES( '" .. pl:UniqueID() .. "', '" .. pl:GetUserGroup() .. "')" )

		end

	end

	sv_PAdmin.notify( nil, {"lightblue", ply:Nick(), "white", " ranked ", "lightblue", pl:Nick(), "white", " to a ", "red", args["rank"] })



end

sv_PAdmin.AddPlugin( Plugin )

function sv_PAdmin.SetupRanks( ply )

	local rank = sql.Query( "SELECT rank FROM padmin_ranks WHERE uniqueid = " .. ply:UniqueID() )
	if rank == nil or rank == false then return end

	if ply:GetUserGroup() != rank[1]["rank"] then ply:SetUserGroup( rank[1]["rank"] ) end

end
hook.Add( "PlayerInitialSpawn", "padmin_setupranks", sv_PAdmin.SetupRanks )