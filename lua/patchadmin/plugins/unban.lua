local Plugin = {
	
	name = "Unban",
	command = "unban",
	alias = {},
	args_required = { "PLAYER_1" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1

	if sql.Query( "SELECT time FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() ) then
		sql.Query( "DELETE FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() )
	end

	sv_PAdmin.notify( ply, "white", "You unbanned ", "lightblue", pl:Nick(), "white", " successfully!" )

end

sv_PAdmin.addPlugin( Plugin )
