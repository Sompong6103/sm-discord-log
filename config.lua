--[[ 
	Release Script Discord Webhook
	author:Sompong
	Mydiscord:https://discord.gg/aCMFgND
]]

Config = {}

Config['Send_basic'] = {
	['chat'] = {webhook = "Your Webhook", color = 16777215},
	['connecting'] = {webhook = "Your Webhook", color = 65280},
	['player_drop'] = {webhook = "Your Webhook", color = 16711680}
}

-- Web color Use ( Decimal color)
-- https://convertingcolors.com/

--[[ 
	You can add logdiscord in file server.lua all script
	EX.
		local massage = "Player ".. xPlayer.name .." BuyItem ".. itemname .." price ".. price .." $"
		TriggerEvent('sm-discord-log:senddiscord', massage , color, source, "Your Webhook discord")

	EX2. add color
		local massage = "Player ".. xPlayer.name .." BuyItem ".. itemname .." price ".. price .." $"
		TriggerEvent('sm-discord-log:senddiscord', massage , 16711680, source, "Your Webhook discord")
]]