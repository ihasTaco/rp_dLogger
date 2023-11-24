local configContent = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
local config = load(configContent)()
local playerConnectTimes = {}
local VORPcore = {}


TriggerEvent("getCore", function(core)
    VORPcore = core
end)

function getID(source)
    local playerID = source
    local identifiers = GetPlayerIdentifiers(playerID)

    for _, id in ipairs(identifiers) do
        if string.match(id, "steam:") then
            return "Steam", id
        elseif string.match(id, "license:") then
            return "FiveM", id
        end
    end
end

function secondsToHoursMinutes(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)

    if hours > 0 then
        return string.format("%dh %02dm", hours, minutes)
    else
        return string.format("%02d minutes", minutes)
    end
end

RegisterNetEvent('onCharacterCreation')
AddEventHandler('onCharacterCreation', function()
    if config.onCharacterCreation.enable == false then
        return
    end

    local webhook = config.systemWebhook

    if config.onCharacterCreation.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local data = {
        embeds = {
            {
                title = config.onCharacterCreate.title,
                color = config.onCharacterCreate.embedColor,
                fields = {
                    {
                        name = config.onCharacterCreate.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.onCharacterCreate.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.onCharacterCreate.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('onCharacterSelected')
AddEventHandler('onCharacterSelected', function()
    if config.onCharacterSelected.enable == false then
        return
    end

    local webhook = config.systemWebhook

    if config.onCharacterSelected.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local User = VORPcore.getUser(source)
    
    local Character = User.getUsedCharacter
    local characterName = Character.firstname .. " " .. Character.lastname
    
    local idType, id = getID(source)

    local data = {
        embeds = {
            {
                title = config.onCharacterSelected.title,
                color = config.onCharacterSelected.embedColor,
                fields = {
                    {
                        name = config.onCharacterSelected.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.onCharacterSelected.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.onCharacterSelected.fields.characterID,
                        value = "```" .. Character.charIdentifier .. "```",
                        inline = true
                    },
                    {
                        name = config.onCharacterSelected.fields.charFirstName,
                        value = "```" .. Character.firstname .. "```",
                        inline = true
                    },
                    {
                        name = config.onCharacterSelected.fields.charLastName,
                        value = "```" .. Character.lastname .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.onLeave.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if config.onStart.enable == false then
        return
    end

    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    local webhook = config.systemWebhook

    if config.onStart.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local data = {
        embeds = {
            {
                title = config.onStart.title,
                color = config.onStart.embedColor,
                description = config.onStart.description,
                footer = {
                    text = config.onStart.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if config.onStop.enable == false then
        return
    end
    
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    local webhook = config.systemWebhook

    if config.onStop.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local data = {
        embeds = {
            {
                title = config.onStop.title,
                color = config.onStop.embedColor,
                description = config.onStop.description,
                footer = {
                    text = config.onStop.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(source, author, text)
    if config.onMessage.enable == false then
        return
    end
    
    local webhook = config.chatWebhook

    if config.onMessage.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local idType, id = getID(source)

    local data = {
        embeds = {
            {
                title = config.onMessage.title,
                description = config.onMessage.description,
                color = config.onMessage.embedColor,
                fields = {
                    {
                        name = config.onMessage.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.onMessage.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.onMessage.fields.message,
                        value = "```" .. text .. "```",
                        inline = false
                    },
                },
                footer = {
                    text = config.onLeave.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function()
    if config.onJoin.enable == false then
        return
    end
    
    local webhook = config.leaveJoinWebhook

    if config.onJoin.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local idType, id = getID(source)
    local playerID = source
    local connectTime = os.time()
    playerConnectTimes[playerID] = connectTime

    local data = {
        embeds = {
            {
                title = config.onJoin.title,
                description = embedDescription,
                color = config.onJoin.embedColor,
                fields = {
                    {
                        name = config.onJoin.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.onJoin.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.onJoin.footerText
                },
                timestamp = timestamp
            }
        }
    }

    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function()
    if config.onLeave.enable == false then
        return
    end
    
    local webhook = config.leaveJoinWebhook

    if config.onLeave.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local idType, id = getID(source)
    local playerID = source
    local connectTime = playerConnectTimes[playerID]
    local playTime = "N/A"

    if connectTime then
        local playTimeSeconds = os.time() - connectTime
        playTime = secondsToHoursMinutes(playTimeSeconds)
    end

    playerConnectTimes[playerID] = nil

    local data = {
        embeds = {
            {
                title = config.onLeave.title,
                description = embedDescription,
                color = config.onLeave.embedColor,
                fields = {
                    {
                        name = config.onLeave.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.onLeave.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    -- {
                    --     name = config.onLeave.fields.playerPlayTime,
                    --     value = tostring(playTime),
                    --     inline = false
                    -- },
                },
                footer = {
                    text = config.onLeave.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)