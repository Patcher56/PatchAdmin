----------
-- RANK --
----------

local PLAYER = FindMetaTable( "Player" )
function PLAYER:GetRank()

	return team.GetName( self:Team() ), team.GetColor( self:Team() )

end

net.Receive( "padmin_loadranks", function( len )

	local teams = team.GetAllTeams()

	-- Setup ranks
	table.foreach( net.ReadTable(), function( id, sql_team )

		local index = tonumber( sql_team.index )
		team.SetUp( index, sql_team.name, Color( unpack( string.Explode( "-", sql_team.color ) ) ), true )
		teams[index].Usergroup = sql_team.usergroup
		teams[index].ID = sql_team.id

	end )

end )

net.Receive( "padmin_createrank", function( len )

	local index = tonumber( net.ReadString() )
	local newTeam = net.ReadTable()
	local teams = team.GetAllTeams()

	team.SetUp( index, newTeam.Name, newTeam.Color, newTeam.Joinable )
	teams[index].Usergroup = newTeam.Usergroup
	teams[index].ID = newTeam.id

end )



-----------
-- BLIND --
-----------
function cl_PAdmin.MakeBlind()

	if !LocalPlayer().isBlind then return end
	draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0 ) )

end
hook.Add( "HUDPaint", "padmin_makeblind", cl_PAdmin.MakeBlind )

net.Receive( "padmin_blinded", function( len )

	if net.ReadString() == "true" then

		LocalPlayer().isBlind = true

	else

		LocalPlayer().isBlind = false

	end

end )



-------------
-- PLUGINS --
-------------

net.Receive( "padmin_getplugins", function( len )

	cl_PAdmin.Plugins = net.ReadTable()

end )
