-------------------------
--  INITIALIZE TABLES  --
-------------------------

sv_PAdmin = {}
cl_PAdmin = {}
sh_PAdmin = {}



-------------------------
--  LOAD CLIENT FILES  --
-------------------------

AddCSLuaFile()
AddCSLuaFile( "patchadmin/client/chat_functions.lua" )
AddCSLuaFile( "patchadmin/client/join.lua" )



--------------------------------
--  LOAD SERVER/CLIENT FILES  --
--------------------------------

if SERVER then

	include( "patchadmin/server/sql.lua" )
	include( "patchadmin/server/admin.lua" )
	include( "patchadmin/server/plugins.lua" )
	
	local files = file.Find( "patchadmin/plugins/*.lua", "LUA" )
	table.foreach( files, function( key, plugin )

		include( "patchadmin/plugins/" .. plugin )

	end )

else

	include( "patchadmin/client/chat_functions.lua" )
	include( "patchadmin/client/join.lua" )
	
end

print( "PatchAdmin geladen..." )
