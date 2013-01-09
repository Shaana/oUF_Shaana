
local addon, namespace = ...

local layout = {}
namespace.layout = layout

--[[basic design

frame_base
	bar_health (height 100% frame_base, ..)
	bar_power
	bar_special 
	text_health
	text_power
	text_name
	text_level
	text_...

--]]

--[[ What do we save where ?
config (basic)
	- height/width
	- colors
	- position (the whole frame_set)
	- font (f.e skurri)								--TODO move to layout ?
	- textures (might have to move that to layouts) --TODO move to layout ?
	- menu options

layout (advanced)
	- frames/bars/backdrops/font_strings
	- sizes
	- position relative to each other
	- general looks
	

--]]

--self the frame we want it anchored to
--NOTE config here is actually the table config[unit]

layout["default"] = function(self, config)
		--hp bar
		print("create_default")
		
		local health_bar = CreateFrame("StatusBar", nil, self) --maybe change to UIParent
		health_bar:SetStatusBarTexture(config.status_bar_texture)
		health_bar:SetHeight(config.height) --replace with pp core functions --> might be a problem though with file loading order
		health_bar:SetWidth(config.width) --replace with pp core functions
		--health_bar:SetStatusBarColor(unpack(config.status_bar_color))
		health_bar:SetPoint(unpack(config.anchor))

		local health_bar_bg = health_bar:CreateTexture(nil, "BACKGROUND")
		health_bar_bg:SetTexture(config.status_bar_texture)
		health_bar_bg:SetAllPoints(health_bar)
		
		--[[
		local temp = CreateFrame("Frame", nil, UIParent)
		temp:SetHeight(50)
		temp:SetWidth(50)
		temp:SetPoint("CENTER",0,0)
		
		local tb = temp:CreateTexture()
		tb:SetAllPoints(temp)
		tb:SetTexture(config.background_texture)
		tb:SetVertexColor(0.5,0.5,0.5)
		--]]
		
		--health_bar.frequentUpdates = config.frequentUpdates or false --oUF option
		health_bar.colorClass = true
		self.Health = health_bar
		--self.Health.bg = health_bar_bg
		--power bar
			
	end
	
layout["player"] = function(self, config)
		print("create_player")
		--default bars, ...
		layout["default"](self, config)
		
		--extra things
		
	end




---helper functions

local function create_bar()
	local bar = CreateFrame("StatusBar", nil, f)
    bar:SetStatusBarTexture(cfg.statusbar_texture)
    bar:SetHeight(f.height)
    bar:SetWidth(f.width)
    bar:SetPoint("CENTER",0,0)


end

local function create_font_string()

end

local function create_frame()

end

local function create_backdrop()

end
