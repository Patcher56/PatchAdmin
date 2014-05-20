http.Fetch(

	"http://ip-api.com/json/",

	function( body, len, headers, code )

		local data = util.JSONToTable( body )

		net.Start( "padmin_joindata" )
			net.WriteString( data["country"] )
		net.SendToServer()

	end

)
