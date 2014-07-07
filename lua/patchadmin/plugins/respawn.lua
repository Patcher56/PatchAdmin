local Plugin = {
	
	name = "Respawn",
	command = "respawn",
	alias = { "spawn" },
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	pl:Spawn()

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "red", " respawned ", "lightblue", pl:Nick(), "white", "!" )

end

sv_PAdmin.AddPlugin( Plugin )
