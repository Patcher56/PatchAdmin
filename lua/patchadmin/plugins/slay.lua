local Plugin = {
	
	name = "Slay",
	command = "slay",
	alias = { "kill" },
	args_required = { "PLAYER_1" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	pl:Kill()
	sv_PAdmin.notify( ply, "lightblue", ply:Nick(), "white", " slayed ", "lightblue", pl:Nick(), "white", "!" )

end

sv_PAdmin.AddPlugin( Plugin )
