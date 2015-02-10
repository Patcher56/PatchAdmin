-----------------------------------
-- SERVER - PLAYER COMMUNICATION --
-----------------------------------

local syncData = {}
net.Receive( "padmin_send", function( len )

	local typ = net.ReadString()
	local insert = tobool( net.ReadBit() )
	if !insert then
		syncData[ typ ] = net.ReadTable()		
	else
		syncData[ typ ] = syncData[ typ ] or {}
		table.insert( syncData[ typ ], net.ReadTable() )
	end

end )



----------
-- RANK --
----------

local PLAYER = FindMetaTable( "Player" )
function PLAYER:getRank()

	return team.GetName( self:Team() ), team.GetColor( self:Team() )

end

function cl_PAdmin.setupTeam( index, name, color, join, group, id )

	local teams = team.GetAllTeams()

	team.SetUp( index, name, color, join )
	teams[index].Usergroup = group
	teams[index].ID = id

end

net.Receive( "padmin_loadranks", function( len )

	table.foreach( net.ReadTable(), function( id, sql_team )
		cl_PAdmin.setupTeam( tonumber( sql_team.index ), sql_team.name, Color( unpack( string.Explode( "-", sql_team.color ) ) ), true, sql_team.usergroup, sql_team.id )
	end )

end )

net.Receive( "padmin_createrank", function( len )

	local index = tonumber( net.ReadString() )
	local newTeam = net.ReadTable()

	cl_PAdmin.setupTeam( index, newTeam.Name, newTeam.Color, newTeam.Joinable, newTeam.Usergroup, newTeam.id )

end )



-----------
-- BLIND --
-----------

function cl_PAdmin.makeBlind()

	if !syncData.blind or !syncData.blind[1] then return end
	draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0 ) )

end
hook.Add( "HUDPaint", "padmin_makeblind", cl_PAdmin.makeBlind )



------------------
-- ANNOUNCEMENT --
------------------

function cl_PAdmin.makeAnnouncement()

	if !syncData.announcement then return end
	table.foreach( syncData.announcement, function( key, ann )

		if SysTime() >= ann[3] then table.remove( syncData.announcement, key ) end
		
		draw.SimpleText( ann[2], "padmin_roboto_32", ScrW() / 2, 100 + ( ( key - 1 ) * 40 ), Color( 255, 255, 255 ), 1, 1, 1, Color( 50, 50, 50 ) )

	end )

end
hook.Add( "HUDPaint", "padmin_makeannouncement", cl_PAdmin.makeAnnouncement )



-------------
-- PLUGINS --
-------------

net.Receive( "padmin_getplugins", function( len )

	cl_PAdmin.Plugins = net.ReadTable()

end )
