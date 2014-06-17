function sv_PAdmin.loadSettings()

	--sql.Query( "DROP TABLE padmin_ranks" )
	--sql.Query( "DROP TABLE padmin_player_ranks" )
	--sql.Query( "DROP TABLE padmin_bans" )

	sql.Query( "CREATE TABLE IF NOT EXISTS padmin_ranks('index' TEXT, 'nameid' TEXT, 'usergroup' TEXT, 'color' TEXT);" )
	sql.Query( "CREATE TABLE IF NOT EXISTS padmin_player_ranks('uid' TEXT, 'rid' TEXT);")
	sql.Query( "CREATE TABLE IF NOT EXISTS padmin_bans(uniqueid INTEGER, time REAL);" )
	
end

sv_PAdmin.loadSettings()
