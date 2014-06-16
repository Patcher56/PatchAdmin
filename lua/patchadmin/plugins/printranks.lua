local Plugin = {
	
	name = "PrintRanks",
	command = "printranks",
	alias = { "ranks" },
	args_required = {},
	args_optional = {}

}

-- PRINT THE RANKS
function Plugin:Call( ply, args )

	PrintTable( team.GetAllTeams() )

	sv_PAdmin.notify( nil, "red", "Ranks", "white", " were printed to the server console!" )

end

sv_PAdmin.AddPlugin( Plugin )
