local Plugin = {
	
	name = "Freeze",
	command = "freeze",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1 or ply

	if !pl.isFrozen then

		pl.isFrozen = true
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " froze ", "lightblue", pl:Nick(), "white", "!" )

	else

		pl.isFrozen = false
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " melted ", "lightblue", pl:Nick(), "white", "!" )

	end

	pl:Freeze( pl.isFrozen )

end

sv_PAdmin.addPlugin( Plugin )
