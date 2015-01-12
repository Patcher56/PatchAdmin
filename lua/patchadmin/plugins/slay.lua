local Plugin = {
	
	name = "Slay",
	command = "slay",
	alias = { "kill" },
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1 or ply

	pl:Kill()
	
	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " slayed ", "lightblue", pl:Nick(), "white", "!" )

end

sv_PAdmin.addPlugin( Plugin )
