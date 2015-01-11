----------------------
--  PLAYER CONVERT  --
----------------------

-- CONVERT PLAYERNAME TO PLAYER
function sv_PAdmin.getPlayer( plyname )

	if plyname == nil then return end

	local result = {}

	table.foreach( player.GetAll(), function( id, player )
		if string.find( string.lower( player:Nick() ), string.lower( plyname ) ) then
			table.insert( result, player )
		end
	end )

	return result

end



--------------
--  PLUGIN  --
--------------

-- PLUGIN MANAGEMENT
sv_PAdmin.Plugins = {}

function sv_PAdmin.addPlugin( inf )

	local name = string.lower( inf.name )
	sv_PAdmin.Plugins[name] = inf

	print( "Registered plugin " .. name )

end

function sv_PAdmin.getPlugin( cmd )

	local p = false

	table.foreach( sv_PAdmin.Plugins, function( name, plugin )
		if plugin.command == cmd or table.HasValue( plugin.alias, cmd ) then p = plugin end
	end )
	
	return p

end



--------------------
--  CHAT COMMAND  --
--------------------

-- RUN THE COMMAND
function sv_PAdmin.Chat( ply, text, public )

	if !string.find( text, "^!" ) or string.len( text ) < 1 then return end

	-- Convert string-command to table
	local cmd = string.Explode( " ", text )
	cmd[1] = string.Replace( cmd[1], "!", "" )

	local function searchPlayer( id )

		local plys = sv_PAdmin.getPlayer( cmd[id + 1] ) or {}
		if #plys == 1 then
			cmd[id + 1] = plys[1]
			return plys[1]
		elseif #plys > 1 then
			sv_PAdmin.notify( ply, "red", "[PAdmin - ERROR] ", "white", "Found ", "lightblue", tostring( #plys ), "white", " players. Please be more specific!" )
			return false
		elseif #plys == 0 then
			return false
		end

	end

	-- Check if plugin is registred
	local plugin = sv_PAdmin.getPlugin( cmd[1] )
	if plugin == false then
		sv_PAdmin.notify( ply, "red", "[PAdmin - ERROR] ", "lightblue", "'" .. cmd[1] .. "'", "white", " is not a registered plugin!" )
		return
	end

	-- Check amount of required arguments
	if #cmd - 1 < #plugin.args_required then
		sv_PAdmin.notify( ply, "red", "[PAdmin - ERROR] ", "white", "You need more ", "lightblue", "args", "white", " to run ", "red", "!" .. cmd[1], "white", "!" )
		return
	end

	-- Combine required and optional arguments
	local args = {}
	local plug_args = {}
	table.Add( plug_args, plugin.args_required )
	table.Add( plug_args, plugin.args_optional )

	-- Check argument-overflow
	local cp = #plug_args
	local cc = #cmd
	if cp < cc - 1 then
		cmd[cp + 1] = table.concat( cmd, " ", cp + 1, cc )
	end

	-- Convert "PLAYER"-keywords to real players
	local players = {}
	table.foreach( plug_args, function( id, arg )
		if string.find( arg, "PLAYER" ) and cmd[id + 1] != nil then
			table.insert( players, searchPlayer( id ) )
		end
	end )

	-- Check possible erros from "PLAYER"-convert
	local errors = {}
	table.foreach( players, function( pid, player )
		if player == false then table.insert( errors, pid ) end
	end )
	if #errors > 0 then
		sv_PAdmin.notify( ply, "red", "[PAdmin - ERROR] ", "white", "Player " .. table.concat( errors, " and " ) .. " couldn't be found!" )
		return ""
	end

	-- Set the args
	table.foreach( plug_args, function( key, value ) args[value] = cmd[ key + 1 ] end )

	-- Run the command
	plugin:Call( ply, args )

	return ""

end
hook.Add( "PlayerSay", "padmin_chat", sv_PAdmin.Chat )



----------------------------------
--  PLAYER CONNECT INFORMATION  --
----------------------------------

function sv_PAdmin.Connect( name, ip )

	local adress = string.sub( ip, 1, string.find( ip, ":" ) - 1 )

	http.Fetch(
		"http://ip-api.com/json/" .. adress,
		function( body, len, headers, code )
			local data = util.JSONToTable( body )
			if data["country"] == nil then return end
			sv_PAdmin.notify( nil, Color( 255, 255, 100 ), name, "white", " connects from ", "lightblue", data["country"], "white", "!" )
		end
	)

end
hook.Add( "PlayerConnect", "padmin_connecting", sv_PAdmin.Connect )



-------------
--  RANKS  --
-------------

-- LOAD PLAYER RANKS
function sv_PAdmin.LoadPlayerRanks( ply, steamid, uniqueid )

	-- Rank player
	local index = tonumber( sql.QueryValue( "SELECT rid FROM padmin_player_ranks WHERE uid = " .. uniqueid ) )

	if index then
		ply:SetTeam( index )
		ply:SetUserGroup( team.GetAllTeams()[index].Usergroup )
	end
	
	-- Message from connected players
	if team.GetName( ply:Team() ) != "Unassigned" then
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " joined as ", team.GetColor( ply:Team() ), team.GetName( ply:Team() ), "white", "!" )
	else
		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " joined as ", team.GetColor( ply:Team() ), "User", "white", "!" )
	end

	local plugins = {}
	table.foreach( sv_PAdmin.Plugins, function( key, value )

		plugins[key] = {}
		plugins[key].cmds = {}

		table.foreach( value.alias, function( k, alias )
			table.insert( plugins[key].cmds, alias )
		end )

		table.insert( plugins[key].cmds, value.command )
		plugins[key].args_required = value.args_required
		plugins[key].args_optional = value.args_optional

	end )
	
	-- Send all commands
	net.Start( "padmin_getplugins" )
		net.WriteTable( plugins )
	net.Send( ply )
	
end
hook.Add( "PlayerAuthed", "padmin_loadplayerranks", sv_PAdmin.LoadPlayerRanks )

function sv_PAdmin.LoadClientRanks( ply, steamid, uniqueid )

	-- Get all saved teams
	local sql_teams = sql.Query( "SELECT * FROM padmin_ranks" )
	if !sql_teams or table.Count( sql_teams ) == 0 then return end

	net.Start( "padmin_loadranks" )
		net.WriteTable( sql_teams )
	net.Send( ply )

end
hook.Add( "PlayerAuthed", "padmin_loadclientranks", sv_PAdmin.LoadClientRanks )

-- LOAD RANKS
function sv_PAdmin.LoadRanks()

	-- Get all saved teams
	local sql_teams = sql.Query( "SELECT * FROM padmin_ranks" )
	local teams = team.GetAllTeams()
	if !sql_teams or table.Count( sql_teams ) == 0 then return end

	-- Setup ranks
	table.foreach( sql_teams, function( id, sql_team )

		local index = tonumber( sql_team.index )
		team.SetUp( index, sql_team.name, Color( unpack( string.Explode( "-", sql_team.color ) ) ), true )
		teams[index].Usergroup = sql_team.usergroup
		teams[index].ID = sql_team.id

	end )
	
end
hook.Add( "InitPostEntity", "padmin_loadranks", sv_PAdmin.LoadRanks )



-------------------------
--  CHAT NOTIFICATION  --
-------------------------

function sv_PAdmin.notify( ply, ... )

	local data = { ... }

	table.foreach( data, function( k, v )

		if v == "red" then data[k] = Color( 255, 0, 0 )
		elseif v == "green" then data[k] = Color( 0, 255, 0 )
		elseif v == "blue" then data[k] = Color( 0, 0, 255 )
		elseif v == "white" then data[k] = Color( 255, 255, 255 )
		elseif v == "lightblue" then data[k] = Color( 0, 161, 255 )
		end

	end )

	net.Start( "padmin_notify" )
		net.WriteTable( data )
	if ply != nil then net.Send( ply ) else net.Broadcast() end

end
