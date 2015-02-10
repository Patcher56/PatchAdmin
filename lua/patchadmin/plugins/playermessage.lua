local Plugin = {
	
	name = "PlayerMessage",
	command = "playermessage",
	alias = { "pm", "@" },
	args_required = { "PLAYER_1", "msg" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1
	local msg = args.msg

	sv_PAdmin.notify( ply, "white", "Sent ", "lightblue", pl:Nick(), "white", ": ", msg )
	sv_PAdmin.notify( pl, "white", "From ", "lightblue", ply:Nick(), "white", ": ", msg )

end

sv_PAdmin.addPlugin( Plugin )
