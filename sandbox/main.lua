
local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end



local momo = "is a cat"
local socket = require "socket"
 
-- the address and port of the server
local address, port = "localhost", 8080
 

udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(-1)

math.randomseed(os.time()) 
entity = tostring(math.random(99999))

-- var isParent: Bool
-- var sequenceId: UUID
-- var sequenceName: String
-- var actionName: String
-- var id: UUID
-- var source: String
-- var name: String
-- var details: String

-- local dg = string.format("%s %s %d %d %s", entity, 'at', 320, 240, "\n")

local function bug(isParent, isChild)
	local functionName = debug.getinfo(2, "n").name
	-- local functionName = debug.getinfo(3, "n").name
		 
	udp:send('{"isParent": true, "isChild": false,  "functionName": '.. '"' .. functionName .. '"' ..', "parentId": "9755437c-df87-11ea-aba6-ff9f78959e0e", "id": '.. '"' .. uuid() .. '"' ..', "source": "mo", "name": "andrew", "details": "momo"}') -- the magic line in question.
end 

local function runTable() 

end

local function runFunction() 

end


local runCoordinator = {
	["currentTable"] = nil,
	["nextHasPath"] = false,
	["nextContext"] = {}

}

local function run(context, sequence, props, functionName)
	bug(0, 1)
	-- print(context, sequence)

	local lastContext = {}

	-- traverse
	for k, v in pairs(sequence) do
	  if type(v) == "table" then
	  	-- runCoordinator["currentTable"] = k
	  	-- print('k', k, v, functionName)

	  	local path = runCoordinator["nextContext"]["path"]
	  	run(lastContext, v[path], props, k)
	  end
	  if type(v) == "function" then
	  	if runCoordinator["currentTable"] == lastContext["path"] then
	  		-- print("plain")
	  		runCoordinator["nextContext"] = v()
	  		runCoordinator["currentTable"] = nil
	  	elseif not runCoordinator[nextHasPath] then
	  		-- print("plain")
	  		lastContext = v()
	  	end
	  end
	end
end

local function meow()
	bug(1, 0)
	print('meow')
end

local function wakeup()
	bug(1, 0)
	print('wakeup')
end

local function sleep()
	bug(1, 0)
	print('sleep')



	if true then
		return { 
			["path"] = "er",
			["props"] = {
				"hellow"
			}
		}
	end

end
-- Do function 

local runMomoSequence = {
	sleep, 
	{
		["success"] = { wakeup },
		["error"] = { meow }
	},
	meow
}

local context = {}
local props = {}
print('start--------------------------')
run(context, runMomoSequence, props)


print('end--------------------------')
































-- mawMaw("hello")
-- mawMawTerraw("hi")

-- local interval = 100e-3       --(1e-3s = 1ms)
-- local prev_time = os.clock()
-- while true do
--     -- call your function here
--     print("This would be your function.")
-- 		udp:send('{"isParent": true, "isChild": false,  "functionName": "petMomo", "parentId": "9755437c-df87-11ea-aba6-ff9f78959e0e", "id": '.. '"' .. uuid() .. '"' ..', "source": "mo", "name": "andrew", "details": "momo"}') -- the magic line in question.

--     while os.clock() - prev_time < interval do end
--     prev_time = os.clock()
-- end

-- udp:send('{"isParent": true, "isChild": false,  "functionName": "petMomo", "parentId": "9755437c-df87-11ea-aba6-ff9f78959e0e", "id": '.. '"' .. uuid() .. '"' ..', "source": "mo", "name": "andrew", "details": "momo"}') -- the magic line in question.

udp:close()

-- print "hello"