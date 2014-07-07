local Plugin = {
	
	name = "Networkinfo",
	command = "netinfo",
	alias = { "net", "ping" },
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	local ping = pl:Ping()
	local packetloss = pl:PacketLoss()

	sv_PAdmin.notify( ply, "white", "Your current ", "lightblue", "Ping", "white", " is ", "red", tostring( ping ), "white", " and your ", "lightblue", "Packetloss", "white", " is ", "red", tostring( packetloss ), "white", "!" )

end

sv_PAdmin.AddPlugin( Plugin )
