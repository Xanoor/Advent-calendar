fx_version 'adamant'

game 'gta5'
author 'Xanoor1#8111 (https://discord.gg/nj8DuncnJx)'
description 'Advent Calendar'

version '1.0'

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	
	'config.lua',
	'server.lua'
}


ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/app.css',
	'html/scripts/app.js',

	'html/calendar.png',
}
