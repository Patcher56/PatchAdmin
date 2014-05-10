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

	local ar = tonumber( args["armor"] )

	if ar != nil then

		pl:SetArmor( ar )

	else

		pl:SetArmor( 100 )

	end

end

sv_PAdmin.AddPlugin( Plugin )
