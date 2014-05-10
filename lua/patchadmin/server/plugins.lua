sv_PAdmin.Plugins = {}

function sv_PAdmin.AddPlugin( inf )

	local name = string.lower( inf["name"] )
	sv_PAdmin.Plugins[ name ] = inf

	print( "Registered plugin " .. name )

end
