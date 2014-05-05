sv_PAdmin.Plugins = {}

function sv_PAdmin.AddPlugin( inf )

	print( "Registered plugin " .. inf["name"] )
	sv_PAdmin.Plugins[ string.lower( inf["name"] ) ] = inf

end
