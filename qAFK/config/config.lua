Config = {}

Config.sendWebhooks = true -- set to false to send Webhooks thru discord. You must have the two configs below filled out in order to do so.
Config.webhook = "WEBHOOKHERE"
Config.webhookImage = "https://i.imgur.com/J4rn73L.png" -- Just a picture that says afk lol

-- AFK Parts
Config.afkmessagestoServer = false -- default false, set to true if you want the whole server to see when someone went afk in chat.

Config.afkx = -2411.26 -- these are the coords the player is sent to when they enter an AFK status. The default spot is some un reachable tower in fort zancudo. Feel free to change these
Config.afky = 3251.81
Config.afkz = 50.50

--Afk Kick
Config.afkKick = true -- set to false if you dont want players to be kicked after being afk for too long
Config.afktimeAllowed = 600 -- 600 sec = 10 Minutes