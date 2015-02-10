local Plugin = {
	
	name = "Bring",
	command = "bring",
	alias = {},
	args_required = { "PLAYER_1" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1

	pl:SetPos( ply:GetPos() )

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " brought ", "lightblue", pl:Nick(), "white", "!" )

end

sv_PAdmin.addPlugin( Plugin )
