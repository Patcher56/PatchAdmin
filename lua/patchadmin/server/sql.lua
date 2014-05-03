--local sql_tables= { "ranks", "bans" }

function sv_PAdmin.loadSettings( tablename )
	sql.Query( "DROP TABLE padmin_ranks" )
	--sql.Query( "DROP TABLE padmin_bans" )

	sql.Query( "CREATE TABLE IF NOT EXISTS padmin_ranks(uniqueid INTEGER, 'rank' TEXT);" )
	sql.Query( "CREATE TABLE IF NOT EXISTS padmin_bans(uniqueid INTEGER, time REAL);" )
	
end

--table.foreach(  )

sv_PAdmin.loadSettings()