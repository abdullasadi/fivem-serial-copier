local QBCore = exports[Config.Core]:GetCoreObject()

if Config.AuthSystem.Admin then 
    RegisterCommand(Config.OpenCommand, function(source)
        TriggerClientEvent('kael-wdis:client:servicemenu', source)
    end, true)
elseif Config.AuthSystem.Job then
    RegisterCommand(Config.OpenCommand, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        local PlayerJob = Player.PlayerData.job.name
        if Config.AuthJobName == PlayerJob then 
            TriggerClientEvent('kael-wdis:client:servicemenu', source)
        end
    end)
end

RegisterNetEvent('kael-wdis:server:copyserials', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local Items = Player.PlayerData.items
    local MsgData = ""
    for k, v in pairs(Items) do 
        local Serial = v.info.serie
        if Serial then 
            MsgData = MsgData .. "```yaml\nWeapon: " .. v.label .. " | Serial: " .. Serial ..  "\n```"
        end
    end    
    local embedData = {
        { 
            ['title'] = CopySerialsHook.Title, 
            ['color'] = 1146986,
            ['footer'] = { 
                ['text'] = 'Found On: ' .. os.date( "!%a %b %d, %H:%M", os.time() + 6 * 60 * 60 ), 
            },
            ['description'] = MsgData,
            ['author'] = { 
                ['name'] = CopySerialsHook.Name, 
                ['icon_url'] = CopySerialsHook.Icon, 
            },
        }
    }
    SendToDiscord(CopySerialsHook.Hook, embedData)
end)

RegisterNetEvent('kael-wdis:server:findserials', function(serial)
    local Player = QBCore.Functions.GetPlayer(source)
    local MsgData = ""

    local PlayerInv = MySQL.query.await('SELECT * FROM `players`', {})
    for k, v in pairs(PlayerInv) do 
        local cID = v.citizenid
        local CkPlayer = QBCore.Functions.GetOfflinePlayerByCitizenId(cID)
        local Items = CkPlayer.PlayerData.items
        for i, d in pairs(Items) do 
            local Serial = d.info.serie
            if Serial == serial then 
                MsgData = MsgData .. "```yaml\nPlayer Inventory: " .. cID .. " | Weapon: " .. d.label .. " | Serial: " .. Serial ..  "\n```"
            end
        end    
    end

    local Stash = MySQL.query.await('SELECT * FROM `stashitems`', {})
    for k, v in pairs(Stash) do 
        local sID = v.stash
        local Items = json.decode(v.items)
        for i, d in pairs(Items) do 
            local Serial = d.info.serie
            if Serial == serial then 
                MsgData = MsgData .. "```yaml\nStash: " .. sID .. " | Weapon: " .. d.label .. " | Serial: " .. Serial ..  "\n```"
            end
        end    
    end

    local GloveBox = MySQL.query.await('SELECT * FROM `gloveboxitems`', {})
    for k, v in pairs(GloveBox) do 
        local Plate = v.plate
        local Items = json.decode(v.items)
        for i, d in pairs(Items) do 
            local Serial = d.info.serie
            if Serial == serial then 
                MsgData = MsgData .. "```yaml\nGlove Box: " .. Plate .. " | Weapon: " .. d.label .. " | Serial: " .. Serial ..  "\n```"
            end
        end    
    end

    local Trunk = MySQL.query.await('SELECT * FROM `trunkitems`', {})
    for k, v in pairs(Trunk) do 
        local Plate = v.plate
        local Items = json.decode(v.items)
        for i, d in pairs(Items) do 
            local Serial = d.info.serie
            if Serial == serial then 
                MsgData = MsgData .. "```yaml\nTrunk: " .. Plate .. " | Weapon: " .. d.label .. " | Serial: " .. Serial ..  "\n```"
            end
        end    
    end

    local embedData = {
        { 
            ['title'] = FindWeaponHook.Title, 
            ['color'] = 1146986,
            ['footer'] = { 
                ['text'] = 'Found On: ' .. os.date( "!%a %b %d, %H:%M", os.time() + 6 * 60 * 60 ), 
            },
            ['description'] = MsgData,
            ['author'] = { 
                ['name'] = FindWeaponHook.Name, 
                ['icon_url'] = FindWeaponHook.Icon, 
            },
        }
    }
    SendToDiscord(FindWeaponHook.Hook, embedData)
end)

function SendToDiscord(hook, embedData)
    PerformHttpRequest(hook, function() end, 'POST', json.encode({ username = 'Weapon Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
end