local Plugin = {
	
	name = "Ban",
	command = "ban",
	alias = {},
	args_required = { "PLAYER_1" },
	args_optional = { "time", "reason" }

}

-- BAN A PLAYER
function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"] or ply

	local reason = args["reason"] or "No reason specified"
	local time = 0

	if args["time"] != nil and args["time"] != 0 then
		time = os.time() + tonumber( args["time"] ) * 60
	end

	sql.Query( "INSERT INTO padmin_bans( uniqueid, time ) VALUES( " .. pl:UniqueID() .. ", " .. time .. ")" )
	pl:Kick( "Banned by " .. ply:Nick() .. "! (" .. reason .. ")" )

	local bans = sql.Query( "SELECT * FROM padmin_bans" )

	sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " banned ", "lightblue", pl:Nick(), "white", " for ", "red", tostring( args["time"] ) .. " minutes", "white", " (" .. reason .. ")!" )

end

-- IF A PLAYER CONNECTS TO THE SERVER
function sv_PAdmin.checkBans( ply, steamid, uniqueid )

	local time = sql.QueryRow( "SELECT time FROM padmin_bans WHERE uniqueid = " .. uniqueid )
	if time == nil then return else time = tonumber( time["time"] ) end
	
	local rem_time = time - os.time()

	if time == 0 or rem_time > 0 then

		ply:Kick( "You are banned from this server for another " .. string.NiceTime( rem_time ) .. "!" )

	else

		sql.Query( "DELETE FROM padmin_bans WHERE uniqueid = " .. uniqueid )

	end

end
hook.Add( "PlayerAuthed", "padmin_checkBans", sv_PAdmin.checkBans )

sv_PAdmin.addPlugin( Plugin )
