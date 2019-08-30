
vRP = Proxy.getInterface("vRP")




  local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  } 
     -- config  --- 
  InfiniteEngineKillers = false -- Should one engine killer last forever?
  EngineDisableTime	 = 15    -- In seconds, how long should a enginekiller take?
  PryBonnetTime         = 10

 


  RegisterNetEvent('use')
  AddEventHandler('use', function()
	  local playerPed		= GetPlayerPed(-1)
	  local coords		= GetEntityCoords(playerPed)
  
	  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		  local vehicle = nil
  
		  if IsPedInAnyVehicle(playerPed, false) then
			  vehicle = GetVehiclePedIsIn(playerPed, false)
		  else
			  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		  end
  
		  if DoesEntityExist(vehicle) then
			  
			  TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			  
  
			  
  
			  Citizen.Wait(PryBonnetTime * 1000)
  
			  StartVehicleAlarm(vehicle)                    -- Disable this if you dont want the cars alarm to trigger
			  SetVehicleDoorOpen(vehicle, 4)   
  
			  Citizen.CreateThread(function()
				  ThreadID = GetIdOfThisThread()
				  CurrentAction = 'kill'
  
				  Citizen.Wait(EngineDisableTime * 1000)
  
				  if CurrentAction ~= nil then
					  SetVehicleEngineHealth(vehicle, 0.0) -- Change to any value you wish 
															-- Minimum: -4000  Maximum: 1000  
															-- -4000: Engine is destroyed  
															-- 0 and below: Engine catches fire and health rapidly declines  
															-- 300: Engine is smoking and losing functionality  
															-- 1000: Engine is perfect  
					  
					  --SetVehicleUndriveable(vehicle, true)  -- enable this if you want to make the vehicle completly undrivable
					  ClearPedTasksImmediately(playerPed)
  
					  
					  SetVehicleDoorShut(vehicle, 4)
				  end
  
				  
  
				  CurrentAction = nil
				  TerminateThisThread()
			  end)
		  end
  
		  Citizen.CreateThread(function()
			  Citizen.Wait(0)
  
			  if CurrentAction ~= nil then
				  SetTextComponentFormat('STRING')
				  AddTextComponentString('Press ~INPUT_VEH_DUCK~ to stop')
				  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
				  if IsControlJustReleased(0, Keys["X"]) then
					  TerminateThread(ThreadID)
					  
					  CurrentAction = nil
				  end
			  end
  
		  end)
		 
	  end
  end)
