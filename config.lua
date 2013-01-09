--﻿local T, C, L, G = unpack(select(2, ...))
local addon, namespace = ...

local config = {}
namespace.config = config


--[[ Valid keys
-only for config["core"]
ui_scale
unit

-for rest
__index
font
height
width
background_texture
layout


--]]



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
	["ui_scale"] = 0.7111, -- find_ui_scale(), --0.8533, --0.7111,
	["use_ui_scale"] = true, --maybe change code. if ui_scale entry exists, use it, otherwise dont
	["unit"] = {"player", "target"}, -- units we want to display, make sure to add a config further down. "target", "tarettarget", "focus", "focustarget", "party", "partypet", "raid"
	["header"] = {nil, nil, "raid party",
					"showParty", true,
					"yOffset", -40,
					"xOffset", -30,
					"maxColums", 2,
					"unitsPerColumn", 2,
					"columnAnchorPoint", "LEFT",
					"columnSpacing", 15,
					
					"oUF-initialConfigFunction", [[
					self:SetWidth(20)
					self:SetHeight(25)
					]],

					},
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
	["status_bar_texture"] = "Interface\\AddOns\\oUF_Shaana\\media\\armory",
	["status_bar_color"] = {0.2,0.2,0.3},
	["frequentUpdates"] = true,
	["anchor"] = {"CENTER", UIParent, "CENTER",0,0},
	["menu"] = "auto",	
	
}

config["player"] = {
	["__index"] = config["default"],
	["layout"] = "player",
	["width"] = 180,
	["height"] = 32,
	["anchor"] = {"CENTER", UIParent, "CENTER", 0, 200},
}

--[[
config["target"] = {
	["__index"] = config["default"],

}
--]]

config["frames_raid"] = {
	["__index"] = config["default"],
}



--enable inheritance
--see documentation on lua metatables for details
for k,_ in pairs(config) do 
	setmetatable(config[k], config[k])
end

--make sure the key values are in the config
assert(config.core)
assert(config.core.unit)
assert(config.default)
assert(config.default.height)
assert(config.default.width)
