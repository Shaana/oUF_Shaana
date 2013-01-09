local addon, namespace = ...

local config = namespace.config
local core = namespace.core
local style = core.style --style class



local function main()
	local units = config.core.unit
	
	--create the styles
	for i = 1, #units do
		style:new(units[i]):apply()
	end
	
end

main()