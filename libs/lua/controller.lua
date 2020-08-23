local json = require "json"
local socket = require "socket"

local controller = {}
local sequences = {}
local Controller = {}
local tracks = {}
local funcs = {}
local providers = {}


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

local function bug(isParent, isChild, name, parentId, source, actionId, propsIn, propsOut)
	print(dump(actionId))

	if actionId == nil then
		actionId = uuid()
	end
	-- print(dump(actionId), parentId)
	udp:send(
	'{"isParent": '.. isParent ..', "isChild": '.. isChild ..',  "functionName": '.. '"' .. name .. '"'
	..', "parentId": "'.. parentId ..'", "id": '.. '"' .. actionId .. '"' ..
	', "source": "'.. source ..'", "name": "andrew", "details": "momo", "propsIn": "'.. (propsIn or "") ..'", '
	..'"propsOut": "'.. (propsOut or "") ..'"}'
	) 
end 


 
-- the address and port of the server
local address, port = "localhost", 8080
 

udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(-1)

-- math.randomseed(os.time()) 
-- entity = tostring(math.random(99999))

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end



local function run(context, sequence, props, name)
	if not context["runId"] then
		-- initial run in, this can recurse
		local runId = uuid()
		context["runId"] = runId 
		bug("true", "false", name, runId, "")
	end

	-- traverse
	for k, v in pairs(sequence) do
	  if type(v) == "table" then
	  	-- if its a table previous thing has a path
	  	local path = context["props"]["path"]
	  	run(context, v[path], props, k)
	  end
	  if type(v) == "function" then
	  		local fname = getName(v)
	  		local actionId = uuid()
	  		bug("false", "true", fname, context["runId"], tracks[fname], actionId, json.encode(context["props"]))
	  		context["props"] = tableMerge(context["props"] or {}, v(context) or {})
	  		bug("false", "true", fname, context["runId"], tracks[fname], actionId, nil, json.encode(context["props"]))
	  		-- print('^^^^^^^^^^^^^^')
	  		-- print(json.encode(context["props"]))
	  end
	end
end


function controller.registerSequence(name, sequence)
	sequences[name] = sequence
end

function controller.registerProvider(name, provider)
	providers[name] = provider 
end


function controller.getSequence(name)
	local sequence = sequences[name]
	return function(props)
		local ctx = {
			["providers"]	= providers,
			["props"] = props
		}

		run(ctx, sequence, props, name)
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