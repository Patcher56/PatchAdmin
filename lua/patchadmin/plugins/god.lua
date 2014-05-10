local Plugin = {
	
	name = "God",
	command = "god",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1", "state", "time" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	if pl == nil then pl = ply end
	
	local state = tonumber( args["state"] )

	local function enable()

		pl:GodEnable()
		pl.isGod = true
		print("god enabled")

	end

	local function disable()

		pl:GodDisable()
		pl.isGod = false

		print("god disabled")

	end

	if GetConVarNumber("sbox_godmode") == 1 then return	end

	if state == nil then

		if pl.isGod != nil and pl.isGod then

			disable()

		else

			enable()

		end

	elseif state == 1 then

		enable()

	elseif state == 0 then

		disable()

	end

end

sv_PAdmin.AddPlugin( Plugin )
