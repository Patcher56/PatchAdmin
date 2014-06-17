local Plugin = {
	
	name = "CreateRank",
	command = "createrank",
	alias = { "crank" },
	args_required = { "nameid", "usergroup", "red", "green", "blue" },
	args_optional = {}

}

-- CREATE A RANK
function Plugin:Call( ply, args )

	local name = args["nameid"]
	local usergroup = args["usergroup"]
	local r, g, b = tonumber( args["red"] ), tonumber( args["green"] ), tonumber( args["blue"] )
	local col = r .. "-" .. g .. "-" .. b .. "-255"
	local teams = team.GetAllTeams()
	local index = table.maxn( teams ) + 1

	-- Check usergroup
	if usergroup != "superadmin" and usergroup != "admin" and usergroup != "user" then
		sv_PAdmin.notify( ply, "red", usergroup, "white", " is not a valid usergroup! Use ", "red", "admin", "white", ", ", "red", "superadmin", "white", " or ", "red", "user", "white", " instead!" )
		return
	end

	-- Create rank
	team.SetUp( index, name, Color( r, g, b ), true )
	teams[index].Usergroup = usergroup

	-- Save rank
	sql.Query( "INSERT INTO padmin_ranks( 'index', 'nameid', 'usergroup', 'color' ) VALUES( '" .. index .. "', '" .. name .. "', '" .. usergroup .. "', '" .. col .. "')" )

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " created the rank ", Color( r, g, b ), name )

end

sv_PAdmin.AddPlugin( Plugin )
