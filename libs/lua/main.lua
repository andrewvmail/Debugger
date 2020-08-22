local c = require "controller"



local function meow()
	print('meow')
end c.track("meow", meow)


local function wakeup()
	print('wakeup')
end c.track("wakeup", wakeup)


local function sleep()
	print('sleep')
	if true then
		return { 
			["path"] = "success",
			["props"] = {
				"hellow"
			}
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
}




print('start--------------------------')

c.registerSequence("momoEat", momoEat);
c.registerSequence("momoEat2", momoEat);
c.registerSequence("momoSleeping", momoEat);

c.getSequence("momoEat")()
c.getSequence("momoEat2")()
c.getSequence("momoSleeping")()

print('end----------------------------')



