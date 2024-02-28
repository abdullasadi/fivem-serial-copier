local QBCore = exports[Config.Core]:GetCoreObject()

RegisterNetEvent('kael-wdis:client:servicemenu', function()
    local ServiceMenu = {
        {
            header = "Service Menu",
            icon = 'fas fa-gun',
            txt = "For Weapon Distributions",
            isMenuHeader = true,
        },
        {
            header = "Copy Weapon Serials",
            icon = "fas fa-clipboard-check",
            txt = "Copy All Weapon Serials In Your Pocket!",
            params = {
                isServer = true,
                event = 'kael-wdis:server:copyserials',
            }
        },
        {
            header = "Find Weapon",
            icon = "fas fa-magnifying-glass",
            txt = "Find Weapon, Who Has It!",
            params = {
                event = 'kael-wdis:client:findserials',
            }
        },
    }
    exports[Config.Menu]:openMenu(ServiceMenu)
end)

RegisterNetEvent('kael-wdis:client:findserials', function()
    local SerialInput = exports[Config.Input]:ShowInput({
        header = "Weapon Serial#",
        submitText = "Find Weapon",
        inputs  = { 
            { 
                text = "Serial Number#", 
                name = "serial", 
                type = "text", 
                isRequired = true, 
            },
        }, 
    })
    if SerialInput ~= nil then
        TriggerServerEvent("kael-wdis:server:findserials", SerialInput.serial)
    end
end)