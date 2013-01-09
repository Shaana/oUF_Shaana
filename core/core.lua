local addon, namespace = ...

local config = namespace.config
local layout = namespace.layout

local core = {}
namespace.core = core


--TODO test with carbagecollect and crap
local function memoize (f)
	local mem = {} 			-- memoizing table
	setmetatable(mem, {__mode = "v"}) -- make it weak
	return function (x) 	-- new version of ’f’, with memoizing
		local r = mem[x]
		if r == nil then 	-- no previous result?
			r = f(x) 		-- calls original function
			print("adding value:", r, " func:", f)
			mem[x] = r 		-- store result for reuse
		end
		return r
	end
end

--loadstring - memoizing version
--local loadstring = memoize(loadstring)


---------------
--[[
  --backdrop table
  local backdrop_tab = {
    bgFile = cfg.backdrop_texture,
    edgeFile = cfg.backdrop_edge_texture,
    tile = false,
    tileSize = 0,
    edgeSize = 5,
    insets = {
      left = 5,
      right = 5,
      top = 5,
      bottom = 5,
    },
  }

--]]



	
----------

local style = {}
style.__index = style
namespace.core.style = style --TODO move to like namespace.class.style? or keep namespace.[file_name].[whatever]

function style.new(self, unit)
	local object = {}
	setmetatable(object, self)
	--TODO, add some global register of all created objects. like .__objects
	object.unit = unit
	object.style_name = "oUF_Shaana_"..unit --might be more efficent to do some table magic here
	return object
end

function style.apply(self)
	print("apply")
	if self.applied then return end

	--check the config for an entry
	--take default if there is no config given
	local config = config[self.unit] or config["default"] --TODO test, pretty sure or doesnt work as intended,
	-- i want it to take the 2nd one if the first config doesnt exist.
	lay_temp = layout[config.layout] or layout["default"]
	print(lay_temp)
	print(layout[config.layout])
	print(layout["default"])
	
	print(self.unit)
	print(self.style_name)
	
	oUF:RegisterStyle(self.style_name, function(self) layout[config.layout](self, config) end)
    oUF:SetActiveStyle(self.style_name)
    oUF:Spawn(self.unit, self.style_name)
	
	self.applied = true
end










