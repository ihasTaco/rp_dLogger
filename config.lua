local config = {
    -- Webhooks --

    -- These can be the same or different webhooks!
    -- Webhook to send chat messages to 
    chatWebhook = "Change Me",
    -- Leave and Join messages will be sent to this webhook
    leaveJoinWebhook = "Change Me",
    -- System Messages will be sent here
    systemWebhook = "Change Me",

    -- Translations & Embed Configurations --

    onStart = {                                                         -- This will send a message when the resource is loaded
        enable = true,
        title = "",
        description = "Connected to Royal Productions | RoyalRP | RedM",
        embedColor = 7824229,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = false,
    },
    onStop = {                                                          -- This will send a message when the resource is unloaded
        enable = true,
        title = "",
        description = "Disconnected from Royal Productions | RoyalRP | RedM",
        embedColor = 14502612,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
    onMessage = {                                                       -- This will send a message when a player sends a message in the chat (also captures commands)
        enable = true,
        title = "Chat Message",
        description = "",
        embedColor = 5592406,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player = "Player",
            playerID = "Player ID",
            message = "Message",
        },
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
    onJoin = {                                                          -- This will send a message when a player joins the server
        enable = true,
        title = "Player Joined",
        embedColor = 3066993,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player = "Player",
            playerID = "Player ID",
        },
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
    onLeave = {                                                         -- This will send a message when a player leaves the server
        enable = true,
        title = "Player Leave",
        embedColor = 16711704,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player = "Player",
            playerID = "Player ID",
            playerPlayTime = "Play Time",
        },
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
    onCharacterCreate = {                                               -- This will send a message once a player creates a new character
        enable = true,
        title = "Character Created",
        embedColor = 11922239,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player = "Player",
            playerID = "Player ID",
        },
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
    onCharacterSelected = {                                             -- This will send a message once a player selects a character (this will also be sent after a player makes a new character)
        enable = true,
        title = "Character Created",
        embedColor = 15844367,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player = "Player",
            playerID = "Player ID",
            characterID = "Character ID",
            charFirstName = "First Name",
            charFirstName = "Last Name",
        },
        footerText = "Royal Productions | RoyalRP | RedM",
        useTimestamp = true,
    },
}

return config