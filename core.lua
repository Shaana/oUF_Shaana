local addon, namespace = ...

local layout = namespace.layout

local core = {}
namespace.core = core

local class = {}
namespace.class = class


--- unit frame style class
local style = {
  __instance = "unit_frame_style",
  __styles = {},
}
namespace.class.style = style

function style.new(self, name, config)
  if style.__styles[name] then
    sCore.core.warning(string.format("Failed to create style %q, name already used. Returning stored style instead.", name))
    return style.__styles[name]
  end

  local object = {}
  sCore.core.inherit(object, style) 
  
  object._config = config or namespace.config["default"]
  object._name = name
  
   --TODO change factory function
  oUF:RegisterStyle(object._name, function(self) 
    layout[object._config.layout](self, object._config) 
  end)
  --oUF:SetActiveStyle(name)
  
  style.__styles[name] = object
  return object
end


function style.get(self, name)
  if not style.__styles[name] then
    sCore.core.debug(string.format("No style named %q available.", name))
  end
  return style.__styles[name]
end


function style.use(self)
  oUF:SetActiveStyle(self._name)
end



--- unit frame class
local frame = {  
  __instance = "unit_frame",
  __frames = {},
}
namespace.class.frame = frame

function frame.new(self, unit, style)
  assert(sCore.core.is_instance(style, namespace.class.style))
  
  style:use()
  --oUF:Spawn(unit, name_of_frame)
  local object = oUF:Spawn(unit, "oUF_Shaana_"..unit)
  
  return object
end


--- unit group class
local group = {  
  __instance = "unit_frame_group",
  __groups = {},
}
namespace.class.group = group


function group.new(self, unit, style)


end








