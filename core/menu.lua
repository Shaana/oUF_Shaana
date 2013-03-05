local addon, namespace = ...

local menu = {}
namespace.menu = menu

--TODO maybe use memoize here? so we only create the menu once

local dropdown = CreateFrame("Frame", addon.."_Dropdown", UIParent, "UIDropDownMenuTemplate")

function menu.show(self)
	dropdown:SetParent(self)
	ToggleDropDownMenu(1, nil, dropdown, "cursor",0,0)
end


menu["auto"] = {}


menu["player"] = {}

init_func = function(self)
	unit = self:GetParent().unit --why like this ?
	if not unit then
		print("not")
		return
	end
	print("init_menu_sha", unit)
	if UnitIsUnit(unit, "player") then
		UnitPopup_ShowMenu(self, "PLAYER", unit, nil, nil)
	end

end


UIDropDownMenu_Initialize(dropdown, init_func, "Menu")












--check key entries
assert(menu.auto)