local w = 600
local h = 270

local function chatType( isTeamChat )
	--[[local chat_field = vgui.Create( "DTextEntry" )	-- create the form as a child of frame
	chat_field:SetPos( 20, 2 * ScrH() / 4 + 300 - 15 - 20 )
	chat_field:SetSize( 300 - 40, 20 )
	chat_field:SetText( "" )
	chat_field.OnEnter = function( self )
		chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
    if ( isTeamChat == false ) then
        print( "Player started typing a message." )
    else
        print( "Player started typing a message in teamchat." )
    end
    --return true

    ]]
end
hook.Add( "StartChat", "Chat", chatType )

local function drawNewChatBox()
	--draw.RoundedBox( 6, 15, 2 * ScrH() / 4, 800, 300, Color( 255, 255, 255, 150 ) )
end
hook.Add( "HUDPaint", "drawNewChatBox", drawNewChatBox)