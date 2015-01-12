local Plugin = {
	
	name = "Networkinfo",
	command = "networkinfo",
	alias = { "net", "ping" },
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1 or ply

	sv_PAdmin.notify( ply, "white", "Your current ", "lightblue", "Ping", "white", " is ", "red", tostring( pl:Ping() ), "white", " and your ", "lightblue", "Packetloss", "white", " is ", "red", tostring( pl:PacketLoss() ), "white", "!" )

end

sv_PAdmin.addPlugin( Plugin )
