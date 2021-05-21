fx_version 'cerulean'
game 'gta5'

author 'D3RP'
description 'Admin Resource'
version '1.0.0'

client_scripts {
  'locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/cl_noclip.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',

  'locale.lua',
  'locales/en.lua',
  'config.lua',
  'server/sv_noclip.lua',
}

file 'locale.js'

dependencies {
	'mysql-async'
}