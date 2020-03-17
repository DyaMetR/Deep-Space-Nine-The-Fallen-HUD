--[[------------------------------------------------------------------
  WEAPON ICONS
  Custom icon display for specific weapons
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local W, H = 128, 64;

  -- All weapon icons
  DS9HUD.Icons = {};

  --[[
    Adds a texture as a weapon icon
    @param {string} weapon class
    @param {number} texture ID
    @param {number|nil} width
    @param {number|nil} height
  ]]
  function DS9HUD:AddWeaponIcon(weaponClass, texture, w, h)
    w = w or W;
    h = h or H;
    DS9HUD.Icons[weaponClass] = {texture = texture, w = w, h = h};
  end

  --[[
    Returns a weapon's icon data
    @param {string} weapon class
    @return {table} icon data
  ]]
  function DS9HUD:GetWeaponIcon(weaponClass)
    return DS9HUD.Icons[weaponClass];
  end

  --[[
    Whether a weapon has a custom icon
    @param {string} weapon class
    @return {boolean} has icon
  ]]
  function DS9HUD:HasWeaponIcon(weaponClass)
    return DS9HUD:GetWeaponIcon(weaponClass) ~= nil;
  end

end
