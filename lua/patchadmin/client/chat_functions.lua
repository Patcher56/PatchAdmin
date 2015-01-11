-------------------
-- NOTIFICATIONS --
-------------------

function cl_PAdmin.notify( data )

	chat.AddText( unpack( data ) )

end

net.Receive( "padmin_notify", function()

	cl_PAdmin.notify( net.ReadTable() )

end )



-----------------
-- CHAT PREFIX --
-----------------

function cl_PAdmin.ChatPrefix( ply, text, team, isDead )

	local tab = {}

	if isDead then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "( DEAD ) " )
	end
	
	if team then
		table.insert( tab, Color( 30, 160, 40 ) )
		table.insert( tab, "( TEAM ) " )
	end
	
	if IsValid( ply ) then
		local rank, color = ply:getRank()
		table.insert( tab, color )
		table.insert( tab, "[" .. rank .. "] " )
		table.insert( tab, ply )
	else
		table.insert( tab, "Console" )
	end
	
	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": " .. text )
	
	chat.AddText( unpack( tab ) )

	return true

end
hook.Add( "OnPlayerChat", "padmin_chatprefix", cl_PAdmin.ChatPrefix )
