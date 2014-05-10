local Plugin = {
	
	name = "Health",
	command = "health",
	alias = { "hp" },
	args_required = {},
	args_optional = { "PLAYER_1", "health" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	if pl == nil then pl = ply end

	local hp = tonumber( args["health"] )
	
	if hp != nil then

		if hp == 0 then

			pl:Kill()
			return

		end

		pl:SetHealth( hp )

	else

		pl:SetHealth( 100 )

	end

end

sv_PAdmin.AddPlugin( Plugin )
