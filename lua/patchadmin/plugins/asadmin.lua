local Plugin = {
	
	name = "AsAdmin",
	command = "asadmin",
	alias = { "aa" },
	args_required = { "msg" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local msg = args.msg

	sv_PAdmin.notify( nil, "red", "[Admins] " .. msg )

end

sv_PAdmin.addPlugin( Plugin )
