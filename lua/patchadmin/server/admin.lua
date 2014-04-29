function sv_PAdmin.check_player( plyname )

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

function sv_PAdmin.chat( ply, text, public )

	if string.find( text, "^!" ) and string.len( text ) > 1 then

		--Converting
		local cmd = string.Explode( " ", text )
		cmd[1] = string.Replace( cmd[1], "!", "" )

		local player = sv_PAdmin.check_player( cmd[ 2 ] ) or {}
		if table.Count( player ) == 1 then
			cmd[ 2 ] = player[1]
		end

		--Check if all required arguments are here, then call the function
		if table.HasValue( table.GetKeys( sv_PAdmin.Plugins ), cmd[1] ) then

			local plugin = sv_PAdmin.Plugins[cmd[1]]

			if table.Count(cmd) - 1 >= table.Count(plugin.args_required) then

				local args = {}
				local plug_args = {}
				table.Add(plug_args, plugin.args_required)
				table.Add(plug_args, plugin.args_optional)

				table.foreach( plug_args, function(key, value)

					args[value] = cmd[ key + 1 ]

				end)

				plugin:Call( ply, args )

			else

				print("not enough args!")

			end
			

		else

			print("not found in library")

		end

		return ""

	end

end
hook.Add( "PlayerSay", "sv_padmin_chat", sv_PAdmin.chat )
