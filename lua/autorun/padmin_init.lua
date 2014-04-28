---------------------
--  CREATE TABLES  --
---------------------

sh_PAdmin = {}
sv_PAdmin = {}
cl_PAdmin = {}



-------------------------
--  LOAD CLIENT FILES  --
-------------------------

AddCSLuaFile()
AddCSLuaFile("patchadmin/client/chat_style.lua")


--------------------------------
--  LOAD SERVER/CLIENT FILES  --
--------------------------------

if SERVER then

	include( "patchadmin/server/chat.lua" )

else

	include( "patchadmin/client/chat_style.lua" )
	
end
