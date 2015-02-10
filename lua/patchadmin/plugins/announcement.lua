local Plugin = {
	
	name = "Announcement",
	command = "announcement",
	alias = { "@@@" },
	args_required = { "time", "msg" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local msg, time = args.msg, tonumber( args.time )
	if time == nil then time = 10 end

	sv_PAdmin.send( ply, "announcement", true, ply, msg, SysTime() + time )

end

sv_PAdmin.addPlugin( Plugin )
