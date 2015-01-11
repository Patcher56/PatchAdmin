-------------------------
--  LOAD CLIENT FILES  --
-------------------------

AddCSLuaFile()
AddCSLuaFile( "patchadmin/client/chat_functions.lua" )
AddCSLuaFile( "patchadmin/client/chat_style.lua" )
AddCSLuaFile( "patchadmin/client/client.lua" )



--------------------------------
--  LOAD SERVER/CLIENT FILES  --
--------------------------------

if SERVER then

	-- Tables
	sv_PAdmin = {}
	sh_PAdmin = {}

	-- Network Strings
	util.AddNetworkString( "padmin_createrank" )
	util.AddNetworkString( "padmin_loadranks" )
	util.AddNetworkString( "padmin_getplugins" )
	util.AddNetworkString( "padmin_notify" )
	util.AddNetworkString( "padmin_joindata" )
	util.AddNetworkString( "padmin_blinded" )

	-- Include Files
	include( "patchadmin/server/sql.lua" )
	include( "patchadmin/server/admin.lua" )
	
	local files = file.Find( "patchadmin/plugins/*.lua", "LUA" )
	table.foreach( files, function( key, plugin )

		include( "patchadmin/plugins/" .. plugin )

	end )

else

	-- Tables
	cl_PAdmin = {}
	sh_PAdmin = {}

	-- Included Files
	include( "patchadmin/client/chat_functions.lua" )
	include( "patchadmin/client/chat_style.lua" )
	include( "patchadmin/client/client.lua" )
	
end

print( "PatchAdmin geladen..." )
