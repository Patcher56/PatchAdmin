local Plugin = {
	
	name = "Strip",
	command = "strip",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1", "fun" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	if !pl.isStripped then

		pl.isStripped = true
		pl.strippedWeapons = {}

		table.foreach( pl:GetWeapons(), function( key, weapon )
			table.insert( pl.strippedWeapons, weapon:GetClass() )
			if args["fun"] == "1" then pl:DropWeapon( weapon ) end
		end )
		
		if !args["fun"] then pl:StripWeapons() end

		sv_PAdmin.notify( ply, "lightblue", ply:Nick(), "red", " stripped ", "lightblue", pl:Nick(), "white", "!" )

	else

		pl.isStripped = false

		table.foreach( pl.strippedWeapons, function( key, wep_class )
			pl:Give( wep_class )
		end )

		sv_PAdmin.notify( ply, "lightblue", ply:Nick(), "white", " has given ", "lightblue", pl:Nick(), "white", " all Weapons ", "red", "back", "white", "!" )

	end

end

sv_PAdmin.AddPlugin( Plugin )
