-------------------------------------
--  SERVER - PLAYER COMMUNICATION  --
-------------------------------------

function sv_PAdmin.send( ply, typ, insert, ... )

	net.Start( "padmin_send" )

		net.WriteString( typ )
		net.WriteBit( insert )
		net.WriteTable( {...} )
			
	if ply == nil then net.Broadcast() else net.Send( ply ) end

end
