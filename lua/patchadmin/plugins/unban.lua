local Plugin = {
	
	name = "Unban",
	command = "unban",
	args_required = { "player" },
	args_optional = {}

}

function Plugin:Call( ply, args )

	local pl = args["player"]
	if pl == nil or !pl:IsPlayer() then return end

	if sql.Query( "SELECT time FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() ) then

		sql.Query( "DELETE FROM padmin_bans WHERE uniqueid = " .. pl:UniqueID() )

	end

end

sv_PAdmin.AddPlugin( Plugin )
