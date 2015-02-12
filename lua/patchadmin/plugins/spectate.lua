local Plugin = {
	
	name = "Spectate",
	command = "spectate",
	alias = { "spec" },
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Spectate( ply, pl )

	ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity( pl )

	self.Strip = sv_PAdmin.getPlugin( "strip" )
	self.Strip:Strip( ply )
	ply.isSpectating = true

end

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1

	if ( !ply.isSpectating and pl ) or ( pl and ply.isSpectating ) then

		self:Spectate( ply, pl )

		sv_PAdmin.notify( ply, "white", "You are now specating ", "lightblue", pl:Nick(), "white", "!" )

	elseif ply.isSpectating then

		ply:UnSpectate()
		self.Strip:Unstrip( ply )
		ply.isSpectating = false

	else

		local entity = ply:GetEyeTrace().Entity
		self:Spectate( ply, entity )

		sv_PAdmin.notify( ply, "white", "You are now specating an entity!" )

	end

end

sv_PAdmin.addPlugin( Plugin )
