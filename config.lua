local config = {}

config.webhooks = {
    -- chat messages will be sent here
    chat   = "CHANGE ME",
    -- player messages will be sent here
    player = "CHANGE ME",
    -- System Messages will be sent here
    system = "CHANGE ME",
}

-- Translations & Embed Configurations --
config.embed = {
    -- When rp_dLogger, or the server starts
    onResourceStart = {
        enable              = true,
        title               = "",
        description         = "Connected to Royal Productions | RoyalRP | RedM",
        embedColor          = 7824229,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When rp_dLogger, or the server shuts down
    onResourceStop = {
        enable              = true,
        title               = "",
        description         = "Disconnected from Royal Productions | RoyalRP | RedM",
        embedColor          = 14502612,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player sends a message in the chat
    onMessage = {
        enable              = true,
        title               = "Chat Message",
        description         = "",
        embedColor          = 5592406,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
            message         = "Message",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player joins the server
    onPlayerJoin = {
        enable              = true,
        title               = "Player Joined",
        embedColor          = 3066993,                                           -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player leaves the server
    onPlayerLeave = {
        enable              = true,
        title               = "Player Leave",
        embedColor          = 16711704,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
            playerPlayTime  = "Play Time",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player creates a new character
    onCharacterCreate = {
        enable              = true,
        title               = "Character Created",
        embedColor          = 11922239,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player selects a character to play (also after the player creates a new character)
    onCharacterSelect = {
        enable              = true,
        title               = "Character Selected",
        embedColor          = 15844367,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
            characterID     = "Character ID",
            charFirstName   = "First Name",
            charLastName    = "Last Name",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

    -- When a player deletes a character to play
    onCharacterDelete = {
        enable              = true,
        title               = "Character Deleted",
        embedColor          = 9109504,                                          -- This has to be an integer (https://www.mathsisfun.com/hexadecimal-decimal-colors.html)
        fields = {
            player          = "Player",
            playerID        = "Player ID",
            characterID     = "Character ID",
            charFirstName   = "First Name",
            charLastName    = "Last Name",
        },
        footerText          = "Royal Productions | RoyalRP | RedM",
        useTimestamp        = true,
    },

}

return config