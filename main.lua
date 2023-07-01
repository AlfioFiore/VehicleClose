ESX = exports['es_extended']:getSharedObject()

local allowedJob = "fib" -- Lavoro consentito per chiudere il veicolo
local allowedJob2 = "ambulance" -- Lavoro consentito per chiudere il veicolo
local allowedJob3 = "police" -- Lavoro consentito per chiudere il veicolo
local vehicleNames = { "modelloVeicolo", "modelloVeicolo", "modelloVeicolo" } -- Nomi dei veicoli consentiti per Job
local vehicleNames2 = { "modelloVeicolo", "modelloVeicolo", "modelloVeicolo" } -- Nomi dei veicoli consentiti per Job2
local vehicleNames3 = { "modelloVeicolo", "modelloVeicolo", "modelloVeicolo" } -- Nomi dei veicoli consentiti per Job3
local interactionDistance = 5.0 -- Distanza massima per interagire con il veicolo

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)


function IsAllowedJob()
    local playerJob = ESX.GetPlayerData().job.name
    return playerJob == allowedJob
end

function IsAllowedJob2()
    local playerJob = ESX.GetPlayerData().job.name
	--print(playerJob == allowedJob2)
    return playerJob == allowedJob2
end

function IsAllowedJob3()
    local playerJob = ESX.GetPlayerData().job.name
	--print(playerJob == allowedJob3)
    return playerJob == allowedJob3
end


function GetClosestVehicle()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local vehicle = nil
    local vehicleDistance = 99999.0

    local vehicles = ESX.Game.GetVehiclesInArea(playerPos, interactionDistance)
    for i = 1, #vehicles do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(playerPos, vehicleCoords, true)
        if distance < vehicleDistance then
            vehicle = vehicles[i]
            vehicleDistance = distance
        end
    end

    return vehicle
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if ESX.PlayerData and ESX.PlayerData.job then
				if IsAllowedJob() then
					if IsControlJustPressed(0, 81) then -- Tasto I
					local vehicle = GetClosestVehicle()
					if DoesEntityExist(vehicle) then
						local vehicleModel = GetEntityModel(vehicle)
						local vehicleDisplayName = GetDisplayNameFromVehicleModel(vehicleModel)
						local retval = GetVehicleDoorsLockedForPlayer(vehicle)
						for i = 1, #vehicleNames do
							if vehicleDisplayName == vehicleNames[i]  and retval == false then
								--print("Veicolo aperto, chiuso")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo chiuso", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, true)
							elseif vehicleDisplayName == vehicleNames[i]  and retval == 1 then
								--print("Veicolo Chiuso, Aperto")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo aperto", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							else
								--print(vehicleDisplayName)
								--print(vehicleNames[i])
								--print("Errore")
							end
						end
					end
				end
            elseif IsAllowedJob2() then
				if IsControlJustPressed(0, 81) then -- Tasto I
					local vehicle = GetClosestVehicle()
					if DoesEntityExist(vehicle) then
						local vehicleModel = GetEntityModel(vehicle)
						local vehicleDisplayName = GetDisplayNameFromVehicleModel(vehicleModel)
						local retval = GetVehicleDoorsLockedForPlayer(vehicle)
						for i = 1, #vehicleNames2 do
							if vehicleDisplayName == vehicleNames2[i]  and retval == false then
								--print("Veicolo aperto, chiuso")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo chiuso", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, true)
							elseif vehicleDisplayName == vehicleNames2[i]  and retval == 1 then
								--print("Veicolo Chiuso, Aperto")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo aperto", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							else
								--print(vehicleDisplayName)
								--print(vehicleNames2[i])
								--print("Errore")
							end
						end
					end
				end
            elseif IsAllowedJob3() then
				if IsControlJustPressed(0, 81) then -- Tasto I
					local vehicle = GetClosestVehicle()
					if DoesEntityExist(vehicle) then
						local vehicleModel = GetEntityModel(vehicle)
						local vehicleDisplayName = GetDisplayNameFromVehicleModel(vehicleModel)
						local retval = GetVehicleDoorsLockedForPlayer(vehicle)
						for i = 1, #vehicleNames3 do
							if vehicleDisplayName == vehicleNames3[i]  and retval == false then
								--print("Veicolo aperto, chiuso")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo chiuso", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, true)
								-- Puoi aggiungere qui eventuali effetti sonori o visivi per indicare che il veicolo è stato chiuso
							elseif vehicleDisplayName == vehicleNames3[i]  and retval == 1 then
								--print("Veicolo Chiuso, Aperto")
								exports['okokNotify']:Alert("VEICOLO", "Veicolo aperto", 10000, 'error')
								SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							else
								--print(vehicleDisplayName)
								--print(vehicleNames3[i])
								--print("Errore")
							end
						end
					end
				end
            end
        end
    end
end)
