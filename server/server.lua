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

    -- Was gonna use this if else statement to tell the webhook which ID to use but will remove this later as its not needed anymore
    for _, id in ipairs(identifiers) do
        if string.match(id, "steam:") then
            return id
        elseif string.match(id, "license:") then
            return id
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

AddEventHandler('onResourceStart', function(resourceName)
    if config.embed.onResourceStart.enable == false then
        return
    end

    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    if config.embed.onResourceStart.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onResourceStart.webhook

    local data = {
        embeds = {
            {
                title = config.embed.onResourceStart.title,
                color = config.embed.onResourceStart.embedColor,
                description = config.embed.onResourceStart.description,
                footer = {
                    text = config.embed.onResourceStart.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if config.embed.onResourceStop.enable == false then
        return
    end
    
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    if config.embed.onResourceStop.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onResourceStop.webhook

    local data = {
        embeds = {
            {
                title = config.embed.onResourceStop.title,
                color = config.embed.onResourceStop.embedColor,
                description = config.embed.onResourceStop.description,
                footer = {
                    text = config.embed.onResourceStop.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('onCharacterCreation')
AddEventHandler('onCharacterCreation', function()
    if config.embed.onCharacterCreate.enable == false then
        return
    end

    if config.embed.onCharacterCreate.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onCharacterCreate.webhook
    local id = getID(source)

    local data = {
        embeds = {
            {
                title = config.embed.onCharacterCreate.title,
                color = config.embed.onCharacterCreate.embedColor,
                fields = {
                    {
                        name = config.embed.onCharacterCreate.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterCreate.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.embed.onCharacterCreate.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('vorpcharacter:deleteCharacter')
AddEventHandler('vorpcharacter:deleteCharacter', function(characterId)
    if config.embed.onCharacterDelete.enable == false then
        return
    end

    if config.embed.onCharacterDelete.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onCharacterDelete.webhook
    local User = VORPcore.getUser(source)
    local id = getID(source)

    local charFirstName = nil
    local charLastName = nil

    local userCharacters = User.getUserCharacters

    -- Checking the users characters and figuring out which character was deleted using the charID
    for _, userCharacter in ipairs(userCharacters) do
        if userCharacter.charIdentifier == characterId then
            charFirstName = userCharacter.firstname
            charLastName = userCharacter.lastname
            break
        end
    end

    if not charFirstName and not charLastName then
        print("Character not found for charIdentifier: " .. characterId)
    end

    local data = {
        embeds = {
            {
                title = config.embed.onCharacterDelete.title,
                color = config.embed.onCharacterDelete.embedColor,
                fields = {
                    {
                        name = config.embed.onCharacterDelete.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterDelete.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterDelete.fields.characterID,
                        value = "```" .. characterId .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterDelete.fields.charFirstName,
                        value = "```" .. charFirstName .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterDelete.fields.charLastName,
                        value = "```" .. charLastName .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.embed.onCharacterDelete.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('onCharacterSelected')
AddEventHandler('onCharacterSelected', function()
    if config.embed.onCharacterSelect.enable == false then
        return
    end

    if config.embed.onCharacterSelect.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onCharacterSelect.webhook
    local User = VORPcore.getUser(source)
    local Character = User.getUsedCharacter
    local id = getID(source)

    local data = {
        embeds = {
            {
                title = config.embed.onCharacterSelect.title,
                color = config.embed.onCharacterSelect.embedColor,
                fields = {
                    {
                        name = config.embed.onCharacterSelect.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterSelect.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterSelect.fields.characterID,
                        value = "```" .. Character.charIdentifier .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterSelect.fields.charFirstName,
                        value = "```" .. Character.firstname .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onCharacterSelect.fields.charLastName,
                        value = "```" .. Character.lastname .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.embed.onCharacterSelect.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(source, author, text)
    if config.embed.onMessage.enable == false then
        return
    end

    if config.embed.onMessage.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onMessage.webhook
    local id = getID(source)

    local data = {
        embeds = {
            {
                title = config.embed.onMessage.title,
                description = config.embed.onMessage.description,
                color = config.embed.onMessage.embedColor,
                fields = {
                    {
                        name = config.embed.onMessage.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onMessage.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onMessage.fields.message,
                        value = "```" .. text .. "```",
                        inline = false
                    },
                },
                footer = {
                    text = config.embed.onMessage.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function()
    if config.embed.onPlayerJoin.enable == false then
        return
    end

    if config.embed.onPlayerJoin.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onPlayerJoin.webhook
    local id = getID(source)
    local playerID = source
    local connectTime = os.time()
    playerConnectTimes[playerID] = connectTime

    local data = {
        embeds = {
            {
                title = config.embed.onPlayerJoin.title,
                description = embedDescription,
                color = config.embed.onPlayerJoin.embedColor,
                fields = {
                    {
                        name = config.embed.onPlayerJoin.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerJoin.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.embed.onPlayerJoin.footerText
                },
                timestamp = timestamp
            }
        }
    }

    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function()
    if config.embed.onPlayerLeave.enable == false then
        return
    end

    if config.embed.onPlayerLeave.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onPlayerLeave.webhook
    local id = getID(source)
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
                title = config.embed.onPlayerLeave.title,
                description = embedDescription,
                color = config.embed.onPlayerLeave.embedColor,
                fields = {
                    {
                        name = config.embed.onPlayerLeave.fields.player,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerLeave.fields.playerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },

                    -- Eventually I want to calculate Player Play Time, but for some reason its not working
                    -- Will look into this soon...
                    -- {
                    --     name = config.embed.onPlayerLeave.fields.playerPlayTime,
                    --     value = tostring(playTime),
                    --     inline = false
                    -- },
                },
                footer = {
                    text = config.embed.onPlayerLeave.footerText
                },
                timestamp = timestamp
            }
        }
    }
    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

RegisterNetEvent('onPlayerDeath')
AddEventHandler('onPlayerDeath', function(killerID)
    if config.embed.onPlayerDeath.enable == false then
        return
    end

    if config.embed.onPlayerDeath.useTimestamp == true then
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    else
        timestamp = false
    end

    local webhook = config.embed.onPlayerDeath.webhook
    local User = VORPcore.getUser(source)
    local Character = User.getUsedCharacter
    local id = getID(source)

    local data = {
        embeds = {
            {
                title = config.embed.onPlayerDeath.title,
                color = config.embed.onPlayerDeath.embedColor,
                fields = {
                    {
                        name = config.embed.onPlayerDeath.fields.vplayer,
                        value = "```" .. GetPlayerName(source) .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerDeath.fields.vplayerID,
                        value = "```" .. id .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerDeath.fields.vcharacterID,
                        value = "```" .. Character.charIdentifier .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerDeath.fields.vcharFirstName,
                        value = "```" .. Character.firstname .. "```",
                        inline = true
                    },
                    {
                        name = config.embed.onPlayerDeath.fields.vcharLastName,
                        value = "```" .. Character.lastname .. "```",
                        inline = true
                    },
                },
                footer = {
                    text = config.embed.onPlayerDeath.footerText
                },
                timestamp = timestamp
            }
        }
    }

    if killerID ~= 0 and killerID ~= 60000 and killerID ~= 255 then
        local killerUser = VORPcore.getUser(killerID)
        local killerCharacter = killerUser.getUsedCharacter

        table.insert(data.embeds[1].fields, 
            -- TODO: Add Ability to see what they were killed with
            {
                name = config.embed.onPlayerDeath.fields.killedWith,
                value = "```Hamburger```",
                inline = false
            },
            {
                name = config.embed.onPlayerDeath.fields.kplayer,
                value = "```" .. GetPlayerName(killerID) .. "```",
                inline = true
            },
            {
                name = config.embed.onPlayerDeath.fields.kplayerID,
                value = "```" .. killerID .. "```",
                inline = true
            },
            {
                name = config.embed.onPlayerDeath.fields.kcharacterID,
                value = "```" .. killerCharacter.charIdentifier .. "```",
                inline = true
            },
            {
                name = config.embed.onPlayerDeath.fields.kcharFirstName,
                value = "```" .. killerCharacter.firstname .. "```",
                inline = true
            },
            {
                name = config.embed.onPlayerDeath.fields.kcharLastName,
                value = "```" .. killerCharacter.lastname .. "```",
                inline = true
            })
    elseif killerID == 0 then
        table.insert(data.embeds[1].fields, {
            name = config.embed.onPlayerDeath.fields.killedBy,
            value = "```Console```",
            inline = false
        })
    elseif killerID == 255 then
        table.insert(data.embeds[1].fields, {
                name = config.embed.onPlayerDeath.fields.killedBy,
                value = "```Ped```",
                inline = false
            })
    end


    TriggerEvent('rp_dWebhook:SendDiscordMessage', data, webhook)
end)

-- TODO

-- onPlayerGiveItem
-- onPlayerGiveMoney
-- onPlayerGiveGold

-- Redem Framework