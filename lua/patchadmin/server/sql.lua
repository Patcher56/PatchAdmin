function sv_PAdmin.loadSettings()

	local function createTable()

		sql.Query( "CREATE TABLE IF NOT EXISTS padmin_ranks('uniqueid' TEXT, 'rank' TEXT);" )
		
		MsgC(
			Color(255, 150, 0),
			"[PatchAdmin] Created new Ranks-Table\n"
		)

	end

	if !sql.TableExists( "padmin_ranks" ) then

		createTable()

	else

		local existing = sql.Query( "PRAGMA table_info(padmin_ranks);" )

		if existing[2] == nil then
			--sql.Query( "DROP TABLE padmin_ranks" )
			MsgC(
				Color(255, 0, 0),
				"[PatchAdmin] There was an error with the Ranks-Table. We deleted it to make a new working one!\n"
			)

		end

	end
	
end

sv_PAdmin.loadSettings()