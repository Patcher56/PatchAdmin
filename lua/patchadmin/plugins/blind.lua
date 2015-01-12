local Plugin = {
	
	name = "Blind",
	command = "blind",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1 or ply

	if !pl.isBlind then

		pl.isBlind = true
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " blinded ", "lightblue", pl:Nick(), "white", "!" )

	else

		pl.isBlind = false
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " unblinded ", "lightblue", pl:Nick(), "white", "!" )

	end

	net.Start( "padmin_blinded" )
		net.WriteString( tostring( pl.isBlind ) )
	net.Send( pl )

end

sv_PAdmin.addPlugin( Plugin )
