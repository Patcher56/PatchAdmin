local Plugin = {
	
	name = "Freeze",
	command = "freeze",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	if !pl.isFrozen then

		pl.isFrozen = true

		pl:Freeze( true )

		sv_PAdmin.notify( ply, "lightblue", ply:Nick(), "white", " has ", "red", "frozen ", "lightblue", pl:Nick(), "white", "!" )

	else

		pl.isFrozen = false

		pl:Freeze( false )

		sv_PAdmin.notify( ply, "lightblue", ply:Nick(), "red", " melted ", "lightblue", pl:Nick(), "white", "!" )

	end

end

sv_PAdmin.AddPlugin( Plugin )
