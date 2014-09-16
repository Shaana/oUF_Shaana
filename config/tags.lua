local addon, namespace = ...

local tags = oUF.Tags
namespace.tags = tags

--Note: There are quiet a few premade tages in 'UF/elements/tags.lua'

--TODO rework (name), to like ["default:hp"] or ["player:hp"]

--[[
use this format

tags.Methods["shaana:hp"] = function(unit)
	return ...
end
tags.Events["shaana:hp"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION" --list of events

--]]

tags.Methods["default:hp"] = function(unit)
	return UnitHealth(unit).."|"..UnitHealthMax(unit)
end
tags.Events["default:hp"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"
