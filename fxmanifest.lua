fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }
author 'Kael Scripts'
description 'Serial Copier Script'
version '1.0.0'

client_scripts {
    'client/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'sv_config.lua',
    'server/**.lua',
}

shared_scripts {
    'config.lua',
}


escrow_ignore { 
    'config.lua',
}