local c = require "controller"
local db = require "db"


local function meow(ctx)
	-- print('meow', dump(ctx))
	return { 
			["angry"] = "yes"
	}
end c.track("meow", meow)


local function wakeup()
	print('wakeup')
end c.track("wakeup", wakeup)


local function sleep()
	print('sleep')
	if true then
		return { 
			["path"] = "success",
			["hungry"] = "yes"
		}
	end
end c.track("sleep", sleep)




local momoEat = {
	sleep, 
	{
		["success"] = { wakeup },
		["error"] = { meow }
	},
	meow,
	meow,
}


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
local function initDb(ctx)
	-- print('initDb', dump(ctx['props']))
	ctx["providers"]["db"].init()
	return {
		["koko"] = "terraw"
	}
end c.track("initDb", initDb)

local initApp = {
	initDb,
	meow,
}



print('start--------------------------')

c.registerProvider("db", db)


c.registerSequence("momoEat", momoEat)
c.registerSequence("momoEat2", momoEat)
c.registerSequence("momoSleeping", momoEat)
c.registerSequence("initApp", initApp)

-- c.getSequence("initApp")({["hello"] = "world"})

c.getSequence("momoEat")()
-- c.getSequence("momoEat2")()
-- c.getSequence("momoSleeping")()

print('end----------------------------')



