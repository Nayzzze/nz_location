ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local location 

createLocation = false 

RMenu.Add('Location', 'main', RageUI.CreateMenu("~b~Location", "~b~Viens louer ta voiture !"))
RMenu:Get('Location', 'main'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Location', 'main').Closed = function()
    createLocation = false
end; 





function openLocation()
    if not createLocation then 
        createLocation = true 
        RageUI.Visible(RMenu:Get('Location', 'main'), true)
            Citizen.CreateThread(function()
                while createLocation do 
                    Citizen.Wait(7)

                    RageUI.IsVisible(RMenu:Get('Location', 'main'), true, true, true, function()
                        if not location then 
                            RageUI.ButtonWithStyle("Panto 🚙", nil, {RightLabel = "500$"}, true, function(Hovered, Active, s)
                                if s then 
                                    RageUI.CloseAll()
                                    location = false 
                                    CreateLocation = false 
                                    local vehName = "panto"
                                    local vehHash = GetHashKey(vehName)
                                    RequestModel(vehHash)
                                    while not HasModelLoaded(vehHash) do 
                                        Citizen.Wait(100)
                                    end
                                    local vehicle = CreateVehicle(vehHash, -1030.28, -2732.32, 20.07, 239.0, true, false)
                                    SetVehicleNumberPlateText(vehicle, "LOCATION")
                                    SetVehicleMaxSpeed(vehicle, 38.0)
                                end
                            end)

                            RageUI.ButtonWithStyle("Faggio 🛵", nil, {RightLabel = "500$"}, true, function(Hovered, Active, s)
                                if s then  
                                    RageUI.CloseAll()
                                    location = false 
                                    CreateLocation = false 
                                    local vehName2 = "faggio2"
                                    local vehHash2 = GetHashKey(vehName2)
                                    RequestModel(vehHash2)
                                    while not HasModelLoaded(vehHash2) do 
                                        Citizen.Wait(100)
                                    end
                                    local vehicle2 = CreateVehicle(vehHash2, -1030.28, -2732.32, 20.07, 239.0, true, false)
                                    SetVehicleNumberPlateText(vehicle2, "LOCATION")
                                    SetVehicleMaxSpeed(vehicle2, 38.0)
                                end
                            end)
                        end
                    end, function()
                    end)
                end
            end)
    end
end


--------------------- POS DU MENU --------------------------- 

local createLocation = {
    tkt = {
        {pos = vector3(-1036.06, -2733.49, 20.16)}
    }
}


local pedName = "s_m_m_autoshop_01"
local pedHash = GetHashKey(pedName)
RequestModel(pedHash)
while not HasModelLoaded(pedHash) do 
      Citizen.Wait(100)
 end
 local ped = CreatePed("PED_TYPE_GANG_BIKER_1", pedHash, -1035.578, -2732.748, 19.1693, 145.18, false, false)
 SetEntityInvincible(ped, true)
 SetBlockingOfNonTemporaryEvents(ped, true)
 FreezeEntityPosition(ped, true)

Citizen.CreateThread(function()
    while true do
        local pCoords2 = GetEntityCoords(GetPlayerPed(-1))
        local activerfps = false
        local dst = GetDistanceBetweenCoords(pCoords2, true)
        for k,v in pairs(createLocation.tkt) do
            if #(pCoords2 - v.pos) < 1 then
                activerfps = true
                RageUI.Text({ message = "Appuyez sur [~b~E~s~] pour louer une voiture !", time_display = 1 })
                if IsControlJustReleased(0, 38) then     
                    openLocation()      
                end
            end
        end
        if activerfps then
            Wait(5)
        else
            Wait(1000)
        end
    end
end)
