local addon, namespace = ...

local layout = {}
namespace.layout = layout

local pp = sCore.core.pp
--TODO maybe create little helper functions which can be added up
-- like for for castbar, one for buffs, one for cds, health, mana, power bars, 

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
    --Note: 'self' is the anchor generated by oUF for all frames (health_bar, name_text, auras, ... ) related to that unit
    --       This is the area used for targeting the unit (left click)

    ---common frame behavior
    self:RegisterForClicks("AnyUp") --for menu
    --Note: No need to set attributes, oUF does that
    --self:SetAttribute("*type1", "target")
    --self:SetAttribute('*type2', 'togglemenu') --any right click with modifier (e.g shift-right-click) 
    
    --enables tooltips for units
    self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

    local b = config["border_thickness"]
    local j = 8/12
    
		---health bar
		print("create_default")
		pp.register(self)
		
		--this is the 'parent' frame, this is also used to target players
		--therefor we want this as big as all bars/borders together
		self:SetSize(config.width, config.height) --TODO make bigger
		self:SetPoint(unpack(config.anchor))
		
		local bg = self:CreateTexture(nil, "BORDER")
		bg:SetTexture(0,0,0,1)
		bg:SetAllPoints(self)
		
		--Note: The parent is responsible for show/hide (childeren are hidden with parent frame)
		--      the anchor can be a different frame!
		--      THAT TRUE ????
		local health_bar = CreateFrame("StatusBar", "health", self) --maybe change to UIParent
		pp.register(health_bar)
		health_bar:SetStatusBarTexture(config.status_bar_texture)
		health_bar:SetHeight(config.height*j - 3*b) --replace with pp core functions --> might be a problem though with file loading order
		health_bar:SetWidth(config.width - 2*b) --replace with pp core functions
		--health_bar:SetStatusBarColor(unpack(config.status_bar_color))
		--health_bar:SetPoint(unpack(config.anchor))
		health_bar:SetPoint("TOPLEFT", b, -b) --TODO anchor to self, prob topleft corner

    health_bar.colorClass = true
    health_bar.colorHealth = true

		--local health_bar_bg = health_bar:CreateTexture(nil, "BACKGROUND")
		local health_bar_bg = health_bar:CreateTexture(nil, "BORDER")
		pp.register(health_bar_bg)
		--health_bar_bg:SetTexture(config.status_bar_texture)
		health_bar_bg:SetTexture(0.3,0.3,0.3,1)
		health_bar_bg:SetAllPoints(health_bar)
		health_bar_bg:SetHorizTile(false)
	
    self.Health = health_bar
		self.Health.bg = health_bar_bg
		
		local name = health_bar:CreateFontString(nil, "OVERLAY")
    name:SetFont("Interface\\AddOns\\oUF_Shaana\\media\\ExpresswayRg.ttf", 16, "THINOUTLINE")
    name:SetShadowColor(0,0,0,0.5)
    name:SetShadowOffset(0,-0)
    name:SetPoint("LEFT", health_bar, "LEFT", 2, 0)
    name:SetJustifyH("LEFT")
		self:Tag(name, "[name]")		
		
		
		local power_bar =  CreateFrame("StatusBar", "power", self)
		pp.register(power_bar)
		power_bar:SetStatusBarTexture(config.status_bar_texture)
    power_bar:SetHeight(config.height*(1-j) - 3*b)
    power_bar:SetWidth(config.width - 2*b)
		power_bar:SetPoint("TOPLEFT",b, -(config.height*j -b))
		
    power_bar.frequentUpdates = true
    power_bar.colorPower = true
	   
    local power_bar_bg = power_bar:CreateTexture(nil, "BACKGROUND")
    power_bar_bg:SetAllPoints(power_bar)
    power_bar_bg:SetTexture(1, 1, 1, .5) 
	   
	   --[[
	               0.568627450980392, -- [1]
            0.780392156862745, -- [2]
            0.980392156862745, -- [3]
	   --]]
	   
	   
    self.Power = power_bar
    self.Power.bg = power_bar_bg
    
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

		
		
		--[[
		--self.Health.bg = health_bar_bg
		--power bar
		
		--menu
		self.menu = namespace.menu_func
		
		--self:SetAttribute("*type2", "menu") --any right click with modifieres. For example: shift-right_click 
		self:SetScript("OnEnter", UnitFrame_OnEnter)
		self:SetScript("OnLeave", UnitFrame_OnLeave)
		self:RegisterForClicks("AnyUp")
		--]]
		
		 -- Position and size
    local myBar = CreateFrame('StatusBar', nil, self.Health)
    myBar:SetPoint('TOP')
    myBar:SetPoint('BOTTOM')
    myBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    myBar:SetWidth(200)
    
    local otherBar = CreateFrame('StatusBar', nil, self.Health)
    otherBar:SetPoint('TOP')
    otherBar:SetPoint('BOTTOM')
    otherBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    otherBar:SetWidth(200)
    
    local absorbBar = CreateFrame('StatusBar', nil, self.Health)
    absorbBar:SetPoint('TOP')
    absorbBar:SetPoint('BOTTOM')
    absorbBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    absorbBar:SetWidth(200)
    
    local healAbsorbBar = CreateFrame('StatusBar', nil, self.Health)
    healAbsorbBar:SetPoint('TOP')
    healAbsorbBar:SetPoint('BOTTOM')
    healAbsorbBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    healAbsorbBar:SetWidth(200)
    -- Register with oUF
    self.HealPrediction = {
      myBar = myBar,
      otherBar = otherBar,
      absorbBar = absorbBar,
      healAbsorbBar = healAbsorbBar,
      maxOverflow = 1.3,
      frequentUpdates = true,
    }
		
		
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
