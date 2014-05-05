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

-- RUN THE COMMAND
function sv_PAdmin.chat( ply, text, public )

	if string.find( text, "^!" ) and string.len( text ) > 1 then

		-- CONVERTING
		local cmd = string.Explode( " ", text )
		cmd[1] = string.Replace( cmd[1], "!", "" )

		local player = sv_PAdmin.getPlayer( cmd[ 2 ] ) or {}
		if table.Count( player ) == 1 then
			cmd[ 2 ] = player[1]
		end

		-- CHECK REGISTERED PLUGINS
		if table.HasValue( table.GetKeys( sv_PAdmin.Plugins ), cmd[1] ) then

			local plugin = sv_PAdmin.Plugins[ cmd[1] ]

			-- Check if all required arguments are here, then call the function
			if table.Count( cmd ) - 1 >= table.Count( plugin.args_required ) then

				local args = {}
				local plug_args = {}
				table.Add( plug_args, plugin.args_required )
				table.Add( plug_args, plugin.args_optional )

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

				-- Run the command
				plugin:Call( ply, args )

			else

				-- There are some missing args
				sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "white", "You need more ", "lightblue", "args", "white", " to run ", "red", "!" .. cmd[1], "white", "!" } )

			end
			

		else

			-- The called command is not registered
			sv_PAdmin.notify( ply, { "red", "[PAdmin - ERROR] ", "lightblue", "'" .. cmd[1] .. "'", "white", " is not a registered plugin!" } )

		end

		return ""

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
