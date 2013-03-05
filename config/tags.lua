
local addon, namespace = ...

local tags = oUF.Tags
namespace.tags = tags

--[[
use this format

tags.Methods["shaana:hp"] = function(unit)
	return ...
end
tags.Events["shaana:hp"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION" --list of events

--]]

tags.Methods["shaana:hp"] = function(unit)
	return UnitHealth(unit).."|"..UnitHealthMax(unit)
end
tags.Events["shaana:hp"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"
