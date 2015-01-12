local Plugin = {
	
	name = "Teleport",
	command = "teleport",
	alias = { "tp" },
	args_required = { "PLAYER_1" },
	args_optional = { "PLAYER_2" }

}

function Plugin:Call( ply, args )

	local from = args.PLAYER_1
	local to = args.PLAYER_2
	
	if !to then
		to = from
		from = ply
	end

	from:SetPos( to:GetPos() )

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " teleported ", "red", from:Nick(), "white", " to ", "red", to:Nick(), "white", "!" )

end

sv_PAdmin.addPlugin( Plugin )
