local Plugin = {
	
	name = "Armor",
	command = "armor",
	alias = { "ar" },
	args_required = {},
	args_optional = { "PLAYER_1", "armor" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	if pl == nil then pl = ply end

	local ar = math.Clamp( tonumber( args["armor"] ) or 100, 0, 1000000000 )
	pl:SetArmor( ar )

	sv_PAdmin.notify( ply, { "lightblue", ply:Nick(), "white", " set the ", "red", "armor", "white", " for ", "lightblue", pl:Nick(), "white", " to ", "red", tostring( ar ), "white", "!" } )

end

sv_PAdmin.AddPlugin( Plugin )
