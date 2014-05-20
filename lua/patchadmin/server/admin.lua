-----------------------
--  NETWORK STRINGS  --
-----------------------

util.AddNetworkString( "padmin_notify" )



--------------------
--  CHAT COMMAND  --
--------------------

-- CONVERT PLAYERNAME TO PLAYER
function sv_PAdmin.getPlayer( plyname )

	if plyname == nil then return end

	local plys = player.GetAll()
	local result = {}

	table.foreach( plys, function( id, player )

		if string.find( string.lower( player:Nick() ), string.lower( plyname ) ) then
			table.insert( result, player )
		end

	end )

	return result

end

function sv_PAdmin.isPlugin( cmd )

	local plug = false

	table.foreach( sv_PAdmin.Plugins, function( name, plugin )

		if plugin["command"] == cmd or table.HasValue( plugin["alias"], cmd ) then plug = plugin end

	end )
	
	return plug

end

-- RUN THE COMMAND
function sv_PAdmin.chat( ply, text, public )

	if string.find( text, "^!" ) and string.len( text ) > 1 then

		-- CONVERTING
		local cmd = string.Explode( " ", text )
		cmd[1] = string.Replace( cmd[1], "!", "" )

		local function searchPlayer( id )

			local plys = sv_PAdmin.getPlayer( cmd[id + 1] ) or {}
			if #plys == 1 then
				cmd[id + 1] = plys[1]
				return plys[1]
			elseif #plys > 1 then
				sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "white", "Found ", "lightblue", tostring( #plys ), "white", " players. Please be more specific!" } )
				return false
			elseif #plys == 0 then
				return false
			end

		end

		-- CHECK REGISTERED PLUGINS
		local plugin = sv_PAdmin.isPlugin( cmd[1] )

		if plugin != false then

			-- Check if all required arguments are here, then call the function
			if #cmd - 1 >= #plugin.args_required then

				local args = {}
				local plug_args = {}
				table.Add( plug_args, plugin.args_required )
				table.Add( plug_args, plugin.args_optional )

				-- Check if the arguments contain the "player"-keyword
				local players = {}
				table.foreach( plug_args, function( id, arg )

					if string.find( arg, "PLAYER" ) and cmd[id + 1] != nil then
						table.insert( players, searchPlayer( id ) )
					end 

				end )

				-- If there are more args than needed
				local cp = #plug_args
				local cc = #cmd
				if cp < cc - 1 then
					cmd[cp + 1] = table.concat( cmd, " ", cp + 1, cc )
				end

				-- Set the args
				table.foreach( plug_args, function( key, value )
					args[value] = cmd[ key + 1 ]
				end )

				local errors = {}
				table.foreach( players, function( pid, player )

					if player == false then table.insert( errors, pid ) end

				end )

				if #errors > 0 then

					sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "white", "Player " .. table.concat( errors, " and " ) .. " couldn't be found!" } )
					return ""

				end

				-- Run the command
				plugin:Call( ply, args )

			else

				-- There are some missing args
				sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "white", "You need more ", "lightblue", "args", "white", " to run ", "red", "!" .. cmd[1], "white", "!" } )

			end
			
			return ""

		else

			-- The called command is not registered
			sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "lightblue", "'" .. cmd[1] .. "'", "white", " is not a registered plugin!" } )

		end

	end

end
hook.Add( "PlayerSay", "sv_padmin_chat", sv_PAdmin.chat )



-------------------------
--  CHAT NOTIFICATION  --
-------------------------

function sv_PAdmin.notify( ply, data )

	for k, v in pairs( data ) do

		if v == "red" then data[k] = Color( 255, 0, 0 )
		elseif v == "green" then data[k] = Color( 0, 255, 0 )
		elseif v == "blue" then data[k] = Color( 0, 0, 255 )
		elseif v == "white" then data[k] = Color( 255, 255, 255 )
		elseif v == "lightblue" then data[k] = Color( 0, 161, 255 )
		end

	end

	net.Start( "padmin_notify" )
		net.WriteTable( data )
	if ply != nil then net.Send( ply ) else net.Broadcast() end

end
