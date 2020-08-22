local socket = require "socket"

local controller = {}
local sequences = {}
local Controller = {}
local tracks = {}
local funcs = {}


function getName(funct)
	-- print('getName', funct)
	for i,v in pairs(funcs) do
		if v == funct then
			-- print('return', i)
			return i
		end
	end
end

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


local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

local function bug(isParent, isChild, name, id, source)
	udp:send(
	'{"isParent": '.. isParent ..', "isChild": '.. isChild ..',  "functionName": '.. '"' .. name .. '"'
	..', "parentId": "'.. id ..'", "id": '.. '"' .. uuid() .. '"' ..
	', "source": "'.. source ..'", "name": "andrew", "details": "momo"}'
	) 
end 


 
-- the address and port of the server
local address, port = "localhost", 8080
 

udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(-1)

math.randomseed(os.time()) 
entity = tostring(math.random(99999))

local function run(context, sequence, props, name, runCoordinator)

	if not runCoordinator["sentName"] then
		runCoordinator["id"] = uuid()
		bug("true", "false", name, runCoordinator["id"], "")
		runCoordinator["sentName"] = true
	end

	-- name, val = debug.getlocal (1, 2)
	-- print(name, val)
	-- local info = debug.getinfo(3)
	-- print('debug')

	-- print(dump(info))

	local lastContext = {}

	-- traverse
	for k, v in pairs(sequence) do
	  if type(v) == "table" then
	  	-- runCoordinator["currentTable"] = k
	  	-- print('k', k, v, functionName)

	  	local path = runCoordinator["nextContext"]["path"]
	  	run(lastContext, v[path], props, k, runCoordinator)
	  end
	  if type(v) == "function" then
	  	if runCoordinator["currentTable"] == lastContext["path"] then
	  		local fname = getName(v)
	  		-- print(dump(tracks))
	  		-- print('hhhhhhhhhhhhhhhhhhhh', fname)
	  		bug("false", "true", fname, runCoordinator["id"], tracks[fname])
	  		runCoordinator["nextContext"] = v()
	  		runCoordinator["currentTable"] = nil
	  	elseif not runCoordinator[nextHasPath] then
	  		local fname = getName(v)
	  		bug("false", "true", fname, runCoordinator["id"], tracks[fname])
	  		lastContext = v()
	  	end
	  end
	end
end


function controller.registerSequence(name, sequence)
	sequences[name] = sequence
end

function controller.getSequence(name)
	local sequence = sequences[name]
	return function()

		local runCoordinator = {
			["currentTable"] = nil,
			["nextHasPath"] = false,
			["nextContext"] = {},
			["sentName"] = false
		}

		run({}, sequence, {}, name, runCoordinator)
	end
end

function controller.track(name, func)
	-- remove @ prefix
	local file = debug.getinfo(2).source:gsub('%@', "")
	local line = debug.getinfo(2).currentline
	tracks[name] = file .. ':' .. line
	funcs[name] = func
	-- print("track", file .. ':' .. line)

end

function __FILE__() return debug.getinfo(2,'S').source end
function __LINE__() return debug.getinfo(2, 'l').currentline end


return controller