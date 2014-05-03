local Plugin = {
	
	name = "Ban",
	command = "ban",
	args_required = { "player" },
	args_optional = { "time", "reason" }

}

function Plugin:Call( ply, args )

	if args["player"] != nil and !args["player"]:IsPlayer( ) then return end

	local reason = args["reason"] or "No reason specified"
	local time = 0

	if args["time"] != nil and args["time"] != 0 then

		time = os.time() + tonumber(args["time"]) * 60

	end

	sql.Query( "INSERT INTO padmin_bans( uniqueid, time ) VALUES( " .. args["player"]:UniqueID() .. ", " .. time .. ")" )
	args["player"]:Kick( "Banned by " .. ply:Nick() .. "! (" .. reason .. ")" )

	local bans = sql.Query( "SELECT * FROM padmin_bans" )

	PrintTable(bans)

end

sv_PAdmin.AddPlugin( Plugin )

function sv_PAdmin.connectBanCheck( ply, steamid, uniqueid )

	local time = sql.QueryRow( "SELECT time FROM padmin_bans WHERE uniqueid = " .. uniqueid)
	if time == nil then return else time = tonumber(time["time"])end
	local rem_time = time - os.time()

	if time == 0 or rem_time > 0 then

		ply:Kick( "You are banned from this server for another " .. string.NiceTime(rem_time) .. "!")

	else

		sql.Query("DELETE FROM padmin_bans WHERE uniqueid = " .. uniqueid)

	end

end
hook.Add( "PlayerAuthed", "padmin_connectbancheck", sv_PAdmin.connectBanCheck)