local addon, namespace = ...

local config = {}
namespace.config = config


--Note: If you want to use inheritance then add
--["__index"] = table,

config["core"] = {

	["unit"] = {"player", "target", "focus"}, -- units we want to display, make sure to add a config further down. "target", "tarettarget", "focus", "focustarget", "party", "partypet", "raid"
	--checkout for more options http://wowprogramming.com/utils/xmlbrowser/test/FrameXML/SecureGroupHeaders.lua
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

--TODO make default config mandatory
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

config["focus"] = {
  ["__index"] = config["default"],
  ["layout"] = "player",
  ["width"] = 180,
  ["height"] = 32,
  ["anchor"] = {"CENTER", UIParent, "CENTER", 200, 200},
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
