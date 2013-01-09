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
	
	--spawn header
	--oUF:SpawnHeader(config.core.header)
	--oUF:SpawnHeader(nil,nil,"raid,party", "oUF-initialConfigFunction")
	--TODO this doesnt belong here
	
end

main()