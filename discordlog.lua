--[[ 
	Release Script Discord Webhook
	author:Sompong
	Mydiscord:https://discord.gg/aCMFgND
]]

function sanitize(string)
    return string:gsub('%@', '')
end

AddEventHandler('chatMessage', function(source, name, msg)
   sendToDiscord(sanitize(GetPlayerName(source)).." ใด้พิม ".. msg .."", Config['Send_basic']['chat'].color, source, Config['Send_basic']['chat'].webhook)
end)

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    sendToDiscord(sanitize(GetPlayerName(source)).." is connecting to the server ", Config['Send_basic']['connecting'].color, source, Config['Send_basic']['connecting'].webhook)
end)

AddEventHandler('playerDropped', function(reason)
    sendToDiscord(sanitize(GetPlayerName(source)).." has left the server Reason: ".. reason .."", Config['Send_basic']['player_drop'].color, source, Config['Send_basic']['player_drop'].webhook)
end)

RegisterServerEvent('sm-discord-log:senddiscord')
AddEventHandler('sm-discord-log:senddiscord', function(text, color, src, discord_webhook)
    sendToDiscord(text, color, src, discord_webhook)
end)

function sendToDiscord(name, color, src, discord_webhook)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    local ids = ExtractIdentifiers(src)

    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = "Identifier:** ".. identifiers.steam .."**\nLink Steam: **https://steamcommunity.com/profiles/".. tonumber(ids.steam:gsub("steam:", ""),16) .."**\n Rockstar: **".. identifiers.license .."**\n Discord: <@".. ids.discord:gsub("discord:", "") .."> |  Discord ID: **".. identifiers.discord .."** \n IP Address: **".. GetPlayerEndpoint(src) .."**",
              ["footer"] = {
                  ["text"] = "เวลา: ".. os.date ("%X") .." - ".. os.date ("%x") .."",
              },
          }
      }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end



function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end
