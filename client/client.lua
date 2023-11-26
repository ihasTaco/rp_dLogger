-- Debug Kill player command
RegisterCommand("killme", function()
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, 0)
end, false)

RegisterNetEvent("vorp:initNewCharacter")
AddEventHandler("vorp:initNewCharacter", function()
    TriggerServerEvent('onCharacterCreation', charid)
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charId)
    TriggerServerEvent('onCharacterSelected', charid)
end)

-- Player Death Event --

-- I couldn't figure out a better way to check if a player has died
-- if you have a better solution please let me know
local isDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local health = GetEntityHealth(playerPed)

        if health <= 0 and not isDead then
            isDead = true
            local killerEntity = GetPedSourceOfDeath(playerPed)

            print(json.encode(killerEntity))
            
            if killerEntity then
                print("killerEntity: " .. killerEntity)
                local killerEntityType = GetEntityType(killerEntity)
                -- Determine if the killer is a player, NPC, or something else
                if killerEntityType == 1 then -- 1: Ped, 2: Vehicle, 3: Object
                    -- If it's a Ped, check if it's a player
                    local killerPlayer = NetworkGetPlayerIndexFromPed(killerEntity)
                    print("killerPlayer: " .. killerPlayer)
                    if killerPlayer < 255 then
                        local killerServerId = GetPlayerServerId(killerPlayer)
                        print("killerServerID: " .. killerServerId)
                        TriggerServerEvent("onPlayerDeath", killerServerId)
                    else
                        TriggerServerEvent("onPlayerDeath", 255)
                    end
                elseif killerEntityType == 0 then
                    TriggerServerEvent("onPlayerDeath", 0)
                end
            else
                TriggerServerEvent("onPlayerDeath", 60000)
            end
        elseif health > 0 and isDead then
            isDead = false
        end
    end
end)

-- End Player Death Event --