local noclipActive = false

Citizen.CreateThread(function()

    local scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    
    local index = 1
    local currentSpeed = Config.Speeds[index].speed
    local followCamMode = true

    while true do
        Citizen.Wait(1)

        if IsControlJustPressed(1, Config.Controls.openKey) then
            TriggerServerEvent('admin:noClip')
        end

        if noclipActive then
            if Config.DisableWeaponWheel then
                DisableControlAction(0, 37, true)
                if(IsPedArmed(GetPlayerPed(-1), 1 | 2 | 4)) then 
                    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), 1)
                end
            end

            if not IsHudHidden() then
                PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
                PopScaleformMovieFunctionVoid()
                
                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(5)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, Config.Controls.openKey, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_toggle"))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(4)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, Config.Controls.camMode, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_camera"))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(3)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, Config.Controls.goDown, true))
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, Config.Controls.goUp, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_updown"))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(2)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(1, Config.Controls.turnRight, true))
                N_0xe83a3e3557a56640(GetControlInstructionalButton(1, Config.Controls.turnLeft, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_leftright"))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(1)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(1, Config.Controls.goBackward, true))
                N_0xe83a3e3557a56640(GetControlInstructionalButton(1, Config.Controls.goForward, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_forbackwards"))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(0)
                N_0xe83a3e3557a56640(GetControlInstructionalButton(2, Config.Controls.changeSpeed, true))
                BeginTextCommandScaleformString("STRING")
                AddTextComponentScaleform(_U("noclip_speed", Config.Speeds[index].label))
                EndTextCommandScaleformString()
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
                PopScaleformMovieFunctionVoid()

                DrawScaleformMovieFullscreen(scaleform)            
            end

            local yoff = 0.0
            local zoff = 0.0

            if IsDisabledControlJustPressed(1, Config.Controls.camMode) then
                followCamMode = not followCamMode
            end

            if IsControlJustPressed(1, Config.Controls.changeSpeed) then
                if index ~= #Config.Speeds then
                    index = index+1
                    currentSpeed = Config.Speeds[index].speed
                else
                    currentSpeed = Config.Speeds[1].speed
                    index = 1
                end
            end
				
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 33, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 35, true)
            DisableControlAction(0, 266, true)
            DisableControlAction(0, 267, true)
            DisableControlAction(0, 268, true)
            DisableControlAction(0, 269, true)
            DisableControlAction(0, 44, true)
            DisableControlAction(0, 20, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(0, 74, true)

			if IsDisabledControlPressed(0, Config.Controls.goForward) then
                if Config.FrozenPosition then
                    yoff = -Config.Offsets.y
                else 
                    yoff = Config.Offsets.y
                end
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goBackward) then
                if Config.FrozenPosition then
                    yoff = Config.Offsets.y
                else
                    yoff = -Config.Offsets.y
                end
			end

            if not followCamMode and IsDisabledControlPressed(0, Config.Controls.turnLeft) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+Config.Offsets.h)
			end
			
            if not followCamMode and IsDisabledControlPressed(0, Config.Controls.turnRight) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-Config.Offsets.h)
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goUp) then
                zoff = Config.Offsets.z
			end
			
            if IsDisabledControlPressed(0, Config.Controls.goDown) then
                zoff = -Config.Offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            if Config.FrozenPosition then
                SetEntityRotation(noclipEntity, 0.0, 0.0, 180.0, 0, false)
            else 
                SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            end
            if(followCamMode) then
                SetEntityHeading(noclipEntity, GetGameplayCamRelativeHeading());
            else
                SetEntityHeading(noclipEntity, heading);
            end
            if Config.FrozenPosition then
                SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, not noclipActive, not noclipActive, not noclipActive)
            else 
                SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
            end
            SetLocalPlayerVisibleLocally(true);
        end
    end
end)

RegisterNetEvent('admin:enableNoClip')
AddEventHandler('admin:enableNoClip', function()
    noclipActive = not noclipActive

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        noclipEntity = PlayerPedId()
    end
    
    if noclipActive then
        SetEntityVisible(noclipEntity, false, false);
        SetEntityAlpha(PlayerPedId(), 51, 0)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetEntityAlpha(noclipEntity, 51, 0)
        end
    else
        SetEntityVisible(noclipEntity, true, false);
        ResetEntityAlpha(PlayerPedId())
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            ResetEntityAlpha(noclipEntity)
        end
    end

    if Config.FrozenPosition then SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+180) end
    SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
    FreezeEntityPosition(noclipEntity, noclipActive)
    SetEntityInvincible(noclipEntity, noclipActive)
    SetVehicleRadioEnabled(noclipEntity, not noclipActive)
    SetEveryoneIgnorePlayer(noclipEntity, noclipActive);
    SetPoliceIgnorePlayer(noclipEntity, noclipActive);
end)