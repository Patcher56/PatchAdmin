local Plugin = {
	
	name = "God",
	command = "god",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	if GetConVarNumber("sbox_godmode") == 1 then
		sv_PAdmin.notify( ply, "red", "[PAdmin - ERROR] ", "white", "ConVar ", "lightblue", "sbox_godmode", "white", " is currently ", "red", "enabled", "white", "!" )
		return
	end

	if !pl.isGod then

		pl:GodEnable()
		pl.isGod = true
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " enabled ", "red", "godmode", "white", " for ", "lightblue", pl:Nick(), "white", "!" )

	else

		pl:GodDisable()
		pl.isGod = false
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " disabled ", "red", "godmode", "white", " for ", "lightblue", pl:Nick(), "white", "!" )

	end

end

sv_PAdmin.addPlugin( Plugin )
