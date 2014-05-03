local Plugin = {
	
	name = "Kick",
	command = "kick",
	args_required = { "player" },
	args_optional = { "reason" }

}

function Plugin:Call( ply, args )

	if args["player"] != nil and !args["player"]:IsPlayer( ) then return end

	local reason = args["reason"] or "No reason specified"

	args["player"]:Kick( "Kicked by " .. ply:Nick() .. "! (" .. reason .. ")" )

end

sv_PAdmin.AddPlugin( Plugin )