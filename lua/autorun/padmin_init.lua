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
--AddCSLuaFile("patchadmin/client/chat_style.lua")



--------------------------------
--  LOAD SERVER/CLIENT FILES  --
--------------------------------

if SERVER then

	include( "patchadmin/server/admin.lua" )

else

	--include( "patchadmin/client/chat_style.lua" )
	
end

print( "padmin geladen..." )
