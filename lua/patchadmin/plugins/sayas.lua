local Plugin = {
	
	name = "SayAs",
	command = "sayas",
	alias = {},
	args_required = { "PLAYER_1", "msg" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1
	local msg = args.msg

	pl:Say( msg )

end

sv_PAdmin.addPlugin( Plugin )
