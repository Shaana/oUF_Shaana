--http://nclabs.org/articles/2
--[[

   - Set the multisampling to 1x (the grafic driver stuff)
   - Store the resolution height in a variable.
   - Set the UI Scale to a hard-coded known value.
   - Multiply every dimension with 768/resoheight and 1/uiscale.



    Every pixelperfect frame must be parented to a parent tree with UIParent on top.
    No pixelperfect frame must use scale and must not be parented to any frame using scale except UIParent.
    In order to size and anchor your frames you must use the methods frame:Size() and frame:Point().

These are the most common issues when it comes down to pixelperfection, but this is not an all-including guide. There are always exceptions you will still run in to. There are a few more exceptions that I did not cover in this article, but I will give you a hint: Font size, backdrop border and tile sizes and other sizes in pixels. These values must be scaled too using the scale function. My suggestion is that you create a global alias for the scale function and that you use that in those cases.

--]]
--
---code to find perfect scale
--[[
local function find_ui_scale()
	local resolution = ({GetScreenResolutions()})[GetCurrentResolution()]
	local res_width, res_height = string.match(resolution, "(%d+)x(%d+)")
	print("perfect scale")
	print(768/res_height)
end

local holder = CreateFrame("Frame")
holder:RegisterEvent("VARIABLES_LOADED")
holder:SetScript("OnEvent", function(holder, event)
    find_ui_scale()
end)
--]]

--[[
local resolution = ({GetScreenResolutions()})[GetCurrentResolution()]
local res_width, res_height = string.match(resolution, "(%d+)x(%d+)")

local uiscale = .64
local px = 768/resoheight/uiscale --factor of one virtual pixel to one real pixel on your screen
 
local holder = CreateFrame("Frame")
holder:RegisterEvent("VARIABLES_LOADED")
holder:SetScript("OnEvent", function(holder, event)
    SetMultisampleFormat(1)
    SetCVar("uiScale", uiscale)
    SetCVar("useUiScale", 1)
end)

--C[general] doesn exist, replace
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C["general"].uiscale
local Scale = function(x)
    return mult*math.floor(x/mult+.5)
end

local function Size(frame, width, height)
	frame:SetSize(Scale(width), Scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(Scale(width))
end

local function Height(frame, height)
	frame:SetHeight(Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = Scale(arg1) end
	if type(arg2)=="number" then arg2 = Scale(arg2) end
	if type(arg3)=="number" then arg3 = Scale(arg3) end
	if type(arg4)=="number" then arg4 = Scale(arg4) end
	if type(arg5)=="number" then arg5 = Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end
--]]