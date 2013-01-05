--﻿local T, C, L, G = unpack(select(2, ...))
local addon, namespace = ...

local config = {}
namespace.config = config

--Note: If you want to use inheritance then add
--["__index"] = table,
--

--for textures always end it in '_texture'

local function find_ui_scale()
	local resolution = ({GetScreenResolutions()})[GetCurrentResolution()]
	local res_width, res_height = string.match(resolution, "(%d+)x(%d+)")
	return 768/res_height
end

--TODO if ui_scale = nil.. then use auto scale etc.

config["core"] = {
	["ui_scale"] = find_ui_scale(), --0.8533, --0.7111,
	["unit"] = {"player", "target", "tarettarget", "focus", "focustarget", "party", "partypet", "raid"}, -- units we want to display, make sure to add a config further down.
	["font"] = "my_font",
}

--always keep this. When no config was found for a specifif unit, we fall back to this config.
config["default"] = {
	["__index"] = config["core"],
	["layout"] = "default",
	["height"] = 20, --needed field
	["width"] = 120, --needed field
	--[""] = nil,
	--["font"] = ,inherit
	["background_texture"] = "Interface\\AddOns\\oUF_Shaana\\media\\armory",

}

config["player"] = {
	["__index"] = config["default"],
	["layout"] = "player",
	["width"] = 100,
}

config["target"] = {
	["__index"] = config["default"],

}

config["frames_raid"] = {
	["__index"] = config["default"],
}

--enable inheritance
--see documentation on lua metatables for details
for k,_ in pairs(config) do 
	setmetatable(config[k], config[k])
end

print(config["default"].ui_scale)
