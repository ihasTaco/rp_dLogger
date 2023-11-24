fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name "rp_dLogger"
author 'ihasTacoFML'
description "A Discord Admin Logging Tool for RedM"
url "https://github.com/ihasTaco/rp_dLogger"

dependencies {
    'rp_dWebhook',
}

client_script {
    'config.lua',
    'client/client.lua',
}

server_script {
    'server/server.lua'
}