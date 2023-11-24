RegisterNetEvent("vorp:initNewCharacter")
AddEventHandler("vorp:initNewCharacter", function()
    TriggerServerEvent('onCharacterCreation', charid)
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charId)
    TriggerServerEvent('onCharacterSelected', charid)
end)