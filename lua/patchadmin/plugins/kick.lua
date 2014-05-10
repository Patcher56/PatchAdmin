local Plugin = {
	
	name = "Kick",
	command = "kick",
	alias = {},
	args_required = { "PLAYER_1" },
	args_optional = { "reason" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply
	if !pl:IsPlayer() then return end

	local reason = args["reason"] or "No reason specified"

	pl:Kick( "Kicked by " .. ply:Nick() .. "! (" .. reason .. ")" )

end

sv_PAdmin.AddPlugin( Plugin )
