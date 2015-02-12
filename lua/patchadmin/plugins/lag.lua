local Plugin = {
	
	name = "Lag",
	command = "lag",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1" }

}

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1

	local allProps = ents.FindByClass( "prop_physics" )
	table.foreach( allProps, function( key, prop )

		if pl and prop:CPPIGetOwner() != pl then return end

		if prop:IsValid() then

			local physics = prop:GetPhysicsObject()
			physics:EnableMotion( false )

		end

	end )

	if pl then

		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " has frozen all physics props of ", "lightblue", pl:Nick(), "!" )

	else

		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " has frozen all physics props!" )

	end

	

end

sv_PAdmin.addPlugin( Plugin )
