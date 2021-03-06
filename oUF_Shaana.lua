local addon, namespace = ...

local config = namespace.config
local core = namespace.core
local style = namespace.class.style
local frame = namespace.class.frame


local function main()
	local units = config["core"]["unit"]
	
	--create the styles
	for i = 1, #units do
    local unit = units[i]
    local s = style:new(unit, config[unit])
    frame:new(unit, s)
	end
	
	--spawn header
	--oUF:SpawnHeader(config.core.header)
	--oUF:SpawnHeader(nil,nil,"raid,party", "oUF-initialConfigFunction")
	--TODO this doesnt belong here
	
end


--NOTE: most of the stuff that follows is no longer used ....


local function gen_hpbar(self)
    --statusbar
    local s = CreateFrame("StatusBar", nil, self)
    s:SetStatusBarTexture("Interface\\AddOns\\oUF_Simple\\media\\statusbar2")
    s:SetHeight(self.height)
    s:SetWidth(self.width)
    s:SetPoint("CENTER",0,0)
    
    local h = CreateFrame("Frame", nil, s)
    h:SetFrameLevel(0)
    h:SetPoint("TOPLEFT",-5,5)
    h:SetPoint("BOTTOMRIGHT",5,-5)
    gen_backdrop(h)
    
    --bg
    local b = s:CreateTexture(nil, "BACKGROUND")
    b:SetTexture("Interface\\AddOns\\oUF_Simple\\media\\statusbar2")
    b:SetAllPoints(s)
    
	--[[
    --debuff highlight
    local dbh = s:CreateTexture(nil, "OVERLAY")
    dbh:SetAllPoints(self)
    dbh:SetTexture("Interface\\AddOns\\oUF_Simple\\media\\debuff_highlight")
    dbh:SetBlendMode("ADD")
    dbh:SetVertexColor(0,0,0,0)

    self.DebuffHighlightAlpha = 1
    self.DebuffHighlightFilter = false

    self.DebuffHighlight = dbh
    --]]
    self.Health = s

  end


local function create_player_style(self)
    --style specific stuff
    self.width = 270
    self.height = 25
    
    self:SetSize(self.width, self.height)
    self:SetPoint("CENTER",UIParent,"CENTER",0,0)
    self:SetScale(1)

    gen_hpbar(self)  
    
    self.Health.colorClass = true
    self.Health.colorHealth = true
    --self.Health.bg.multiplier = 0.3
    --self.Power.colorPower = true
    --self.Power.bg.multiplier = 0.3

end

local function create_target_style(self)
    --style specific stuff
    self.width = 270
    self.height = 25
    
    self:SetSize(self.width, self.height)
    self:SetPoint("CENTER",UIParent,"CENTER",-200,200)
    self:SetScale(1)

    gen_hpbar(self)  
    
    self.Health.colorClass = true
    self.Health.colorHealth = true
    --self.Health.bg.multiplier = 0.3
    --self.Power.colorPower = true
    --self.Power.bg.multiplier = 0.3

end

main()
