function sv_PAdmin.chat( ply, text, public )

	local chat_command = {}

    if string.sub( text, 1, 1 ) == "!" and string.len( text ) > 1 then

    	chat_command = string.Explode( " ", text, false ) --Aufteilung
    	print("Chat Command:")
    	PrintTable(chat_command)

    	print("All players:")
    	PrintTable(player.GetAll())

    	table.foreach( player.GetAll(), function( id, player )

    		print("searching " .. player:Nick() .. " if his name is " .. chat_command[2])
    		if string.find( string.lower(player:Nick()), string.lower(chat_command[2])) != nil then

    			print( "found: " .. player:Nick() )

    		end

    	end)

    	return ""

	end

end
hook.Add( "PlayerSay", "sv_padmin_chat", sv_PAdmin.chat );