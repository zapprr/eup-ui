fx_version 'adamant'
games { 'gta5' }

lua54 'yes'

name 'EUP UI Redux'
description 'A brand new version of EUP UI, with direct support for outfits.ini, and the ability to save outfits.'
author 'Jennifer Adams'

-- This script requires NativeUILua Reloaded to work. Download it from here: https://github.com/sdiaz/NativeUILua_Reloaded
client_script '@NativeUILua_Reloaded/src/NativeUIReloaded.lua'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'