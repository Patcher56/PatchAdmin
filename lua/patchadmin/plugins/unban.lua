local Plugin = {
	
	name = "Unban",
	command = "unban",
	args_required = { "player" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	if args["player"] != nil and !args["player"]:IsPlayer( ) then return end

	if sql.Query( "SELECT time FROM padmin_bans WHERE uniqueid = " .. args["player"]:UniqueID() ) then

		print("unbanned")
		sql.Query("DELETE FROM padmin_bans WHERE uniqueid = " .. args["player"]:UniqueID() )

	end

end

sv_PAdmin.AddPlugin( Plugin )