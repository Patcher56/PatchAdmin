local Plugin = {
	
	name = "Admins",
	command = "admins",
	alias = { "a" },
	args_required = { "msg" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local msg = args.msg

	table.foreach( player.GetAll(), function( k, ply )
		if ply:IsAdmin() or ply:IsSuperAdmin() then
			sv_PAdmin.notify( ply, "red", "[Admin - " .. ply:Nick() .. "] ", "white", msg )
		end
	end )

end

sv_PAdmin.addPlugin( Plugin )
