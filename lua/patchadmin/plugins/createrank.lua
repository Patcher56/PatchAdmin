local Plugin = {
	
	name = "CreateRank",
	command = "createrank",
	alias = { "crank" },
	args_required = { "nameid", "alias", "usergroup", "red", "green", "blue" },
	args_optional = {}

}

-- CREATE A RANK
function Plugin:Call( ply, args )

	local name = args["nameid"]
	local alias = args["alias"]
	local usergroup = args["usergroup"]
	local r, g, b = tonumber( args["red"] ), tonumber( args["green"] ), tonumber( args["blue"] )

	local teams = team.GetAllTeams()

	local index = table.maxn( teams ) + 1

	if usergroup != "superadmin" and usergroup != "admin" and usergroup != "user" then

		sv_PAdmin.notify( ply, "red", usergroup, "white", " is not a valid usergroup! Use ", "red", "'admin', 'superadmin'", "white", " or ", "red", "'user'", "white", " instead!" )
		return

	end

	team.SetUp( index, name, Color( r, g, b ), true )

	teams[index].Alias = alias
	teams[index].Usergroup = usergroup

	local col = teams[index].Color
	col = col.r .. "-" .. col.g .. "-" .. col.b .. "-" .. col.a

	sql.Query( "INSERT INTO padmin_ranks( 'index', 'nameid', 'alias', 'usergroup', 'color' ) VALUES( '" .. index .. "', '" .. name .. "', '" .. alias .. "', '" .. usergroup .. "', '" .. col .. "')" )

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " created the rank ", Color( r, g, b ), name, " (" .. alias .. ")" )

end

sv_PAdmin.AddPlugin( Plugin )
