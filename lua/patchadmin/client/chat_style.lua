-------------------------
-- COMMAND - ASSISTANT --
-------------------------

local search_cmd = ""
local res = { cmd = {}, args_req = {}, args_opt = {} }
function cl_PAdmin.CommandAssistant()

	if search_cmd == "" then return end

	res = {}

	table.foreach( cl_PAdmin.Plugins, function( name, plugin )

		table.foreach( plugin.cmds, function( k, cmd )

			if string.find( cmd, "^" .. search_cmd ) then
				res[cmd] = { args_req = plugin.args_required, args_opt = plugin.args_optional }
			end

		end )

	end )

	if table.Count( res ) == 0 then return end

	draw.RoundedBox( 4, 20, ScrH() / 6 * 5, 725, 22 * table.Count( res ), Color( 0, 0, 0, 200 ) )
	
	local count = 0
	table.foreach( res, function( cmd, info )

		surface.SetFont( "Roboto" )
		local cmd_width = 0
		local args_req_width = 0
		local args_opt_width = 0

		-- Design Vars
		local offset_top = 3
		local box_height = ScrH() / 6 * 5

		cmd_width = surface.GetTextSize( cmd )
		draw.SimpleText( cmd, "Roboto", 25, box_height + count * 20 + offset_top, Color( 255, 75, 0 ) )

		-- Required Arguments
		table.foreach( info.args_req, function( key, arg )

			draw.SimpleText( "(" .. arg .. ")", "Roboto", 25 + cmd_width + args_req_width + 5, box_height + count * 20 + offset_top, Color( 0, 161, 222 ) )
			args_req_width = args_req_width + surface.GetTextSize( "(" .. arg .. ")" ) + 5

		end )

		-- Optional Arguments
		table.foreach( info.args_opt, function( key, arg )

			draw.SimpleText( "[" .. arg .. "]", "Roboto", 25 + cmd_width + args_req_width + args_opt_width + 5, box_height + count * 20 + offset_top, Color( 255, 255, 255 ) )
			args_opt_width = args_opt_width + surface.GetTextSize( "[" .. arg .. "]" ) + 5

		end )

		count = count + 1

	end )
	
end
hook.Add( "HUDPaint", "padmin_commandassistant", cl_PAdmin.CommandAssistant )

function cl_PAdmin.getChat( text )

	if text == "" or !string.find( text, "^!" ) then
		search_cmd = ""
		return
	end

	if string.find( text, " " ) then
		search_cmd = string.Replace( string.sub( text, 1, string.find( text, " " ) - 1 ), "!", "" )
		return
	end

	search_cmd = string.Replace( text, "!", "" )

end
hook.Add( "ChatTextChanged", "padmin_getchat", cl_PAdmin.getChat )

function cl_PAdmin.finishChat()

	search_cmd = ""

end
hook.Add( "FinishChat", "padmin_finishchat", cl_PAdmin.finishChat )

--[[
----------------
--  ANIMATION --
----------------

function cl_PAdmin.Animation( start, goal, duration )
	
	local frames = 1 / FrameTime()
	local diff = math.abs( start - goal )
	local step = diff / ( duration * frames )

	return math.Approach( start, goal, step )

end



-----------------
-- CUSTOM CHAT --
-----------------

-- DEFINE DEFAULT VARIABLES
local w = 600
local h = 270

cl_PAdmin.Chat = {
	
	Typing = false,
	TextSpace = 20,
	Messages = {}

}

-- MAKING THE CHAT BEAUTIFUL
local function ArgToChat( label, x, y, font, ... )

	vararg = {...}

	local curX = x
	local curCol = Color( 255, 255, 255 )
	local result = {}
	local plist = nil
	vararg = table.ClearKeys(vararg)
	table.foreach( vararg, function( key, value )

		if key == 1 then plist = value end

		if type(value) == "string" then

			draw.SimpleTextOutlined( value, font, curX, y, curCol, nil, nil, 1, Color( 100, 100, 100 ) )
			surface.SetFont( font )
			curX = curX + surface.GetTextSize( value )

		elseif type( value ) == "table" then

			curCol = value

		end

	end )

	return result

end

-- WRITE NEW CHAT MESSAGE
local function startChat( isteam )

	cl_PAdmin.Chat.Typing = true

	local ply = LocalPlayer()

	cl_PAdmin.Chat.Frame = vgui.Create( "DFrame" )
	cl_PAdmin.Chat.Frame:SetSize( 500, 200 )
	cl_PAdmin.Chat.Frame:SetPos( 20, 2 * ScrH() / 4 )
	cl_PAdmin.Chat.Frame:ShowCloseButton( false )
	cl_PAdmin.Chat.Frame:SetTitle( "" )
	cl_PAdmin.Chat.Frame:MakePopup()
	function cl_PAdmin.Chat.Frame:Paint()
		draw.RoundedBox( 0, 0, 0, cl_PAdmin.Chat.Frame:GetWide(), cl_PAdmin.Chat.Frame:GetTall(), Color( 0, 0, 0, 0 ) )
	end

	if #cl_PAdmin.Chat.Messages != 0 then

		local y = 200 - 20 - 20 - 20 - 10
		table.foreach( table.Reverse( cl_PAdmin.Chat.Messages ), function( key, message )

			ArgToChat( true, 20, y, "Roboto", cl_PAdmin.Chat.Frame, message.color, message.name .. ": ", Color( 255, 255, 255 ), message.text )
			y = y - cl_PAdmin.Chat.TextSpace
			
		end )

	end

	cl_PAdmin.Chat.chatField = vgui.Create( "DTextEntry", cl_PAdmin.Chat.Frame )	-- create the form as a child of frame
	cl_PAdmin.Chat.chatField:SetPos( 20, 160 )
	cl_PAdmin.Chat.chatField:SetSize( 460, 24 )
	cl_PAdmin.Chat.chatField:SetFont( "Roboto" )
	cl_PAdmin.Chat.chatField:SetText( "" )
	cl_PAdmin.Chat.chatField:SetCaretPos( cl_PAdmin.Chat.chatField:GetCaretPos() )
	--cl_PAdmin.Chat.chatField:RequestFocus()

	cl_PAdmin.Chat.chatField.OnEnter = function( self )

		local msg = self:GetValue()
		cl_PAdmin.Chat.Frame:Remove()
		chat.Close()

		cl_PAdmin.Chat.Typing = false

		if msg == "" then return end

		local newMessage = {
			time = os.time(),
			color = Color( 255, 255, 0 ),
			name = LocalPlayer():Nick(),
			text = msg
		}
		table.insert( cl_PAdmin.Chat.Messages, newMessage )

		RunConsoleCommand( isteam and "say_team" or "say", msg )

	end

	--function cl_PAdmin.Chat.chatField.m_bBackground:Paint()
	--	draw.RoundedBox( 0, 0, 0, cl_PAdmin.Chat.chatField.m_bBackground:GetWide(), cl_PAdmin.Chat.chatField.m_bBackground:GetTall(), Color( 255, 255, 255 ) )
	--	draw.SimpleText( cl_PAdmin.Chat.chatField:GetValue(), "Roboto", 10, 2, Color( 0, 0, 0 ) )
	--end

	return true

end
hook.Add( "StartChat", "startChat", startChat )



----------------------------
-- SHOW ALL CHAT-MESSAGES --
----------------------------

function cl_PAdmin.showChat()

	local showTime = 10

	if cl_PAdmin.Chat.Typing then

		draw.RoundedBox( 0, 20, 2 * ScrH() / 4, 500, 200, Color( 0, 0, 0, 100 ) )

	end

	local maxMsg = math.floor( 130 / cl_PAdmin.Chat.TextSpace )
	
	local HUDmsg = 0
	table.foreach( table.Reverse( cl_PAdmin.Chat.Messages ), function( index, message )

		if !cl_PAdmin.Chat.Typing and message.time < os.time() - showTime then return end

		if HUDmsg >= maxMsg then return end

		ArgToChat( false, 40, ( 2 * ScrH() / 4 + 130 ) - ( cl_PAdmin.Chat.TextSpace ) * HUDmsg, "Roboto", message.color, message.name .. ": " , Color( 255, 255, 255 ), message.text )
		HUDmsg = HUDmsg + 1

	end )

end
hook.Add( "HUDPaint", "showChatHistory", cl_PAdmin.showChat )
]]