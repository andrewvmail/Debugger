local sqlite3 = require("lsqlite3")

local db = {
	["instance"] = nil
}

local width = 78
local function line(pref, suff)
    pref = pref or ''
    suff = suff or ''
    local len = width - 2 - string.len(pref) - string.len(suff)
    print(pref .. string.rep('-', len) .. suff)
end

function db.init() 
	print("db init")
	line(sqlite3.version())
	db["instance"] = sqlite3.open('test.db')
end

return db