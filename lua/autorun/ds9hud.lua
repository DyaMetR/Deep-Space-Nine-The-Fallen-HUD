--[[-----------------
  S T A R  T R E K
  Deep Space Nine
    THE FALLEN
 Heads Up Display
	Version 3.0.3
     29/10/19

By DyaMetR
]]-----------------

DS9HUD = {};
DS9HUD.Version = "3.0.4";

--[[
  METHODS
]]

--[[
  Correctly includes a file
  @param {string} file
  @void
]]--
function DS9HUD:IncludeFile(file)
  if SERVER then
    include(file);
    AddCSLuaFile(file);
  end
  if CLIENT then
    include(file);
  end
end

--[[
  INCLUDES
]]
DS9HUD:IncludeFile("ds9hud/core.lua");
