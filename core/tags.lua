
local addon, namespace = ...
local tags = oUF.Tags

--[[
use this format

tags.Methods["shaana:hp"] = function(unit)
	return ...
end
tags.Events["shaana:hp"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION" --list of events

--]]
