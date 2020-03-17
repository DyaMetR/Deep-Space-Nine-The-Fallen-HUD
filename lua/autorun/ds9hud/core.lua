--[[------------------------------------------------------------------
  CORE
  The core file of the HUD, where the other files are included and the
  default HUD is hid
]]--------------------------------------------------------------------

-- Configuration
DS9HUD:IncludeFile("config/config.lua");

-- Util
DS9HUD:IncludeFile("util/background.lua");
DS9HUD:IncludeFile("util/bar.lua");
DS9HUD:IncludeFile("util/icons.lua");
DS9HUD:IncludeFile("util/numbers.lua");

-- Elements
DS9HUD:IncludeFile("elements/health.lua");
DS9HUD:IncludeFile("elements/ammunition.lua");

-- Data
DS9HUD:IncludeFile("data/icons.lua");

-- Load add-ons
local files, directories = file.Find("autorun/ds9hud/add-ons/*.lua", "LUA");
for _, file in pairs(files) do
  DS9HUD:IncludeFile("add-ons/"..file);
end

--[[
  Hide default HUD
  Draw our custom instead!
]]
if CLIENT then

  -- Hide default HUD
  local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true
  }
  hook.Add("HUDShouldDraw", "ds9hud_hide", function(name)
    if (not DS9HUD:IsEnabled()) then return; end
    if (hide[name]) then return false; end
  end);

  -- Draw HUD
  hook.Add("HUDPaint", "ds9hud_draw", function()
    if (not DS9HUD:IsEnabled()) then return; end
    DS9HUD:DrawVitalSignsPanel(10 * DS9HUD:GetHUDScale(), ScrH() - 10 * DS9HUD:GetHUDScale());
    DS9HUD:DrawWeaponPanel(ScrW() - 10 * DS9HUD:GetHUDScale(), ScrH() - 10 * DS9HUD:GetHUDScale());
  end);

end
