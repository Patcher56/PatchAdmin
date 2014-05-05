function cl_PAdmin.notify( data )

	chat.AddText( unpack( data ) )

end

net.Receive( "padmin_notify", function()

	cl_PAdmin.notify(net.ReadTable())

end )
