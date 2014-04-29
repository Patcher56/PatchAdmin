function sv_PAdmin.check_player( plyname )

	local plys = player.GetAll()
	local result = {}

	table.foreach( plys, function( id, player )

		if string.find( string.lower( player:Nick() ), string.lower( plyname ) ) then
			table.insert( result, player:Nick() )
		end

	end )

	return result

end

function sv_PAdmin.chat( ply, text, public )

	if string.find( text, "^!" ) and string.len( text ) > 1 then

		local cmd = string.Explode( " ", text )

		local player = sv_PAdmin.check_player( cmd[ 2 ] )
		if table.Count( player ) == 1 then
			cmd[ 2 ] = player
		end

		return ""

	end

end
hook.Add( "PlayerSay", "sv_padmin_chat", sv_PAdmin.chat )
