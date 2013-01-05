
local addon, namespace = ...

--[[ What do we save where ?
config (basic)
	- height/width
	- colors
	- position (the whole frame_set)
	- font (f.e skurri)
	- textures (might have to move that to layouts)

layout (advanced)
	- frames/bars/backdrops/font_strings
	- sizes
	- position relative to each other
	- general looks
	

--]]


local layout = {
	["default"] = function(self, ...)
		--hp bar
		
		--power bar
			
	end,
	
	["player"] = function(self, ...)
		--default bars, ...
		layout["default"](self, ...)
		
		--extra things
		
	end,
	
	

}

namespace.layout = layout



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
