local Plugin = {
	
	name = "Jail",
	command = "jail",
	alias = {},
	args_required = {},
	args_optional = { "PLAYER_1", "time" }

}

local function create_ent( pl, model, pos, ang )

	local ent = ents.Create( "prop_physics" )
	if !IsValid( ent ) then return end
	ent:SetModel( model )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:SetMoveType( MOVETYPE_NONE )
	table.insert( pl.jail, ent )

end

local function unjail( pl )

	pl.jailed = false
	table.foreach( pl.jail, function( k, ent )
		ent:Remove()
	end )

	table.foreach( pl.strippedWeapons, function( key, wep_class )
		pl:Give( wep_class )
	end )

	pl:GodDisable()

end

function Plugin:Call( ply, args )

	local pl = args.PLAYER_1 or ply
	local time = args.time or 5

	if !pl.jailed then

		pl.jailed = true
		pl.jail = {}

		local freeze = sv_PAdmin.getPlugin( "freeze" )
		pl:Freeze( true )
		pl:GodEnable()

		pl.strippedWeapons = {}
		table.foreach( pl:GetWeapons(), function( key, weapon )
			table.insert( pl.strippedWeapons, weapon:GetClass() )
			if args.fun == "1" then pl:DropWeapon( weapon ) end
		end )
		pl:StripWeapons()

		local pos = pl:GetPos()

		create_ent( pl, "models/props_phx/construct/metal_plate2x2.mdl", Vector( pos.x, pos.y, pos.z - 10 ), Angle( 0, 0, 0 ) )
		create_ent( pl, "models/props_phx/construct/metal_plate2x2.mdl", Vector( pos.x, pos.y, pos.z + 87.76 ), Angle( 0, 0, 0 ) ) --Roof
		create_ent( pl, "models/props_phx/construct/windows/window2x2.mdl", Vector( pos.x + 23.725, pos.y - 44.1, pos.z + 17 ), Angle( 0, 0, 90 ) )
		create_ent( pl, "models/props_phx/construct/windows/window2x2.mdl", Vector( pos.x + 23.725, pos.y + 47.625, pos.z + 17 ), Angle( 0, 0, 90 ) )
		create_ent( pl, "models/props_phx/construct/windows/window2x2.mdl", Vector( pos.x + 44.1, pos.y + 23.725, pos.z + 17 ), Angle( 0, 90, 90 ) )
		create_ent( pl, "models/props_phx/construct/windows/window2x2.mdl", Vector( pos.x - 47.625, pos.y + 23.725, pos.z + 17 ), Angle( 0, 90, 90 ) )

		pl:SetMoveType( MOVETYPE_WALK )
		pl:Freeze( false )

		timer.Create( "padmin_jailtimer_" .. pl:Nick(), time * 60, 1, function()
			unjail( pl )
		end )

		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " jailed ", "lightblue", pl:Nick(), "white", " for ", "red", tostring( time ), "white", " minutes!" )

	else

		unjail( pl )
		timer.Destroy( "padmin_jailtimer_" .. pl:Nick() )

		sv_PAdmin.notify( nil, "lightblue", ply:Nick(), "white", " unjailed ", "lightblue", pl:Nick(), "white", "!" )

	end

end

local function jailNoClip( pl, noclip )

	return !pl.jailed

end
hook.Add( "PlayerNoClip", "padmin_jailnoclip", jailNoClip )

sv_PAdmin.addPlugin( Plugin )
