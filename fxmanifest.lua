fx_version "bodacious"
game "gta5"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/*",
}