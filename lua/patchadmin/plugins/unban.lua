local Plugin = {
	
	name = "Unban",
	command = "unban",
	alias = {},
	args_required = { "PLAYER_1" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args["PLAYER_1"]
	if pl == nil or !pl:IsPlayer() then return end

	if sql.Query( "SELECT time FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() ) then

		sql.Query( "DELETE FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() )

	end

end

sv_PAdmin.AddPlugin( Plugin )
