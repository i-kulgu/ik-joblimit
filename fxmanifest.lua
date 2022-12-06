name "ik-joblimit"
author "Proportions#8460"
version "1.0.0"
description "Job Limit script by Proportions#8460"
fx_version "cerulean"
game "gta5"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/*.lua',
    'config.lua'
}
client_scripts {'client.lua'}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

lua54 'yes'
