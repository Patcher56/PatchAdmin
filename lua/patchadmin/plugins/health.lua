local Plugin = {
	
	name = "Health",
	command = "health",
	alias = { "hp" },
	args_required = {},
	args_optional = { "PLAYER_1", "health" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	local hp = math.Clamp( tonumber( args["health"] ) or 100, 0, 1000000000 ) 
	pl:SetHealth( hp )
	
	if hp == 0 then
		pl:Kill()
	end

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " set the ", "red", "health", "white", " for ", "lightblue", pl:Nick(), "white", " to ", "red", tostring( hp ), "white", "!" )

end

sv_PAdmin.AddPlugin( Plugin )
