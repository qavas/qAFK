local display = false
afk = nil

--Set the player afk
RegisterNetEvent("qAFK:setAFK")
AddEventHandler("qAFK:setAFK", function(source)
    afk = true
    oldCoords = GetEntityCoords(PlayerPedId())
    NUI(not display)
end)

--Set the player NOT afk
RegisterNetEvent("qAFK:setNot")
AddEventHandler("qAFK:setNot", function(source)
    if afk then
        local ped = PlayerPedId()
        local namep = GetPlayerName(PlayerId())
        local steamsearch = "https://steamcommunity.com/search/users/#text=" .. namep
        local afkPlayer = "[" .. namep .. "]" .. "(" .. steamsearch .. ")" .. " " .. "is now **not** AFK."
        	SetEntityCoords(ped, oldCoords.x, oldCoords.y, oldCoords.z, false, false, false, true)
        	FreezeEntityPosition(ped, false)
        	chat("^1AFK", "You're now NOT afk", {255, 90, 0})
        	    afk = false
        if Config.sendWebhooks then
        	TriggerServerEvent("qAFK:webhook", afkPlayer, "**\nAFK Status: :x: **" .. "Not AFK", 16720170)
        end

    else
        chat("^1ERROR ", "You were not AFK!", {255, 255, 255})
    end
end)


--Exit Callback
RegisterNUICallback("exitNUI", function(data)
    print("DEBUG: NUI Exited.")
    NUI(false)
end)

--Main Callback
RegisterNUICallback("sendplayerisAFK", function(data)
	local playerPed = PlayerPedId() 
    local namep = GetPlayerName(PlayerId())
    local steamsearch = "https://steamcommunity.com/search/users/#text=" .. namep -- tried working on sending actual steam profile many different ways (before asking, yes, I did) if you know how, DM me : qavas#0746
    local afkPlayer = "[" .. namep .. "]" .. "(" .. steamsearch .. ")" .. " " .. "is now AFK."
	if Config.sendWebhooks then
    	TriggerServerEvent("qAFK:webhook", afkPlayer, "**\nAFK Status: :white_check_mark: **" .. data.text, 3145615)
    end
    	TriggerServerEvent("qAFK:sendAFKmessagetoServer", namep)
    	chat("^7[^4AFK^7]", "You're now AFK (Status: " .. data.text .. ")", {90, 255, 90})
    	NUI(false)
    	SetEntityCoords(playerPed, Config.afkx, Config.afky, Config.afkz, false, false, false, true)
    	FreezeEntityPosition(playerPed, true)
end)

--Afk Kick
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if not afk then
        if Config.afkKick then
		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPlayerCoords = GetEntityCoords(playerPed, true)
		if currentPlayerCoords == oldPlayerCoords then
			if time > 0 then
				if time == math.ceil(Config.afktimeAllowed / 2) then
					TriggerEvent("chatMessage", "[AFK WARNING]", {255, 0, 0}, "You'll be kicked in " .. time .. " seconds for being AFK!")
			    end
				if time == math.ceil(Config.afktimeAllowed / 3) then
					TriggerEvent("chatMessage", "[AFK WARNING]", {255, 0, 0}, "You'll be kicked in " .. time .. " seconds for being AFK!")
			    end
				if time == math.ceil(Config.afktimeAllowed / 6) then
					TriggerEvent("chatMessage", "[AFK WARNING]", {255, 0, 0}, "You'll be kicked in " .. time .. " seconds for being AFK!")
			    end
			    time = time - 1
			else
				TriggerServerEvent("qAFK:kickPlayer", Config.afktimeAllowed.. " seconds")
				end
			else
				time = Config.afktimeAllowed
			end
			    oldPlayerCoords = currentPlayerCoords
		    	end
			end
	    end
    end
end)

--Error Callback
RegisterNUICallback("error", function(data)
    chat(data.error, {255, 0, 0})
    NUI(false)
end)

function NUI(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "afkUI",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)

function chat(firstStr, secondStr, color)
    TriggerEvent(
        'chatMessage', firstStr, color, secondStr)
end
