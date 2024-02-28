fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }
author 'Kael Scripts'
description 'Weapon Distributing Script'
version '1.0.0'

client_scripts {
    'client/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**.lua',
}

shared_scripts {
    'sv_config.lua',
    'config.lua',
}


escrow_ignore { 
    'config.lua',
}