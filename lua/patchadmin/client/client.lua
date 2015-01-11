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

	if !LocalPlayer().isBlind then return end
	draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0 ) )

end
hook.Add( "HUDPaint", "padmin_makeblind", cl_PAdmin.makeBlind )

net.Receive( "padmin_blinded", function( len )

	LocalPlayer().isBlind = tobool( net.ReadString() )

end )



-------------
-- PLUGINS --
-------------

net.Receive( "padmin_getplugins", function( len )

	cl_PAdmin.Plugins = net.ReadTable()

end )
