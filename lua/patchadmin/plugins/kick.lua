local Plugin = {
	
	name = "Kick",
	command = "kick",
	args_required = { "player" },
	args_optional = { "reason" }

}

function Plugin:Call( ply, args )

	local pl = args["player"]
	if pl != nil and !pl:IsPlayer() then return end

	local reason = args["reason"] or "No reason specified"

	pl:Kick( "Kicked by " .. ply:Nick() .. "! (" .. reason .. ")" )

end

sv_PAdmin.AddPlugin( Plugin )
