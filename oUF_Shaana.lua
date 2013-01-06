local addon, namespace = ...

local config = namespace.config
local core = namespace.core
local style = core.style --style class



local function main()
	local units = config.core.unit
	
	--create the styles
	for v in ipairs(units) do --replace with #
		local tmp = style:new(v)
		tmp:apply()	
	end
	
end
