--[[------------------------------------------------------------------
  HEALTH INDICATOR
  Bar and number based health and suit armour indicators
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local HEALTH_BODY = Material("ds9hud/health_body.png");
  local SHIELD_BODY = Material("ds9hud/extension.png");
  local HP_W, HP_H, HP_M, HP_VM = 78, 62, 32, 11;
  local AP_W, AP_H, AP_M = 61, 12, 10;
  local HEALTH_BAR = Material("ds9hud/bar.png");
  local ARMOUR_BAR = Material("ds9hud/bar_green.png");

  -- Variables
  local damaged = false;
  local flashed = false;
  local anim = 0;
  local tick = 0;
  local lastHP = 100;

  --[[
    Plays the damage and low health animation
    @void
  ]]
  local function HealthAnimation()
    -- Detect health loss
    local hp = LocalPlayer():Health();
    if (lastHP ~= hp) then
      if (lastHP > hp) then
        damaged = true;
      else
        if (hp >= 10) then anim = 0; end
      end
      lastHP = hp;
    elseif (hp < 10) then
      damaged = true;
    end

    -- Play animation
    if (tick) then
      if (not flashed and damaged) then
        if (anim < 1) then
          anim = math.min(anim + 0.03, 1);
        else
          flashed = true;
        end
      else
        anim = math.max(anim - 0.03, 0);
        if (anim <= 0) then flashed = false; end
        if (hp >= 10) then damaged = false; end
      end
      tick = CurTime() + 0.01;
    end
  end

  --[[
    Draws the health panel
    @param {number} x
    @param {number} y
  ]]
  function DS9HUD:DrawHealth(x, y, value)
    value = value or 0;
    local w, h = HP_W * DS9HUD:GetHUDScale(), HP_H * DS9HUD:GetHUDScale();

    -- Draw body
    surface.SetMaterial(HEALTH_BODY);
    surface.SetDrawColor(Color(255, 255, 255));
    surface.DrawTexturedRect(x, y, w, h);

    -- Draw foreground
    HealthAnimation();
    DS9HUD:DrawNumber(x + math.floor(57 * DS9HUD:GetHUDScale()), y + h - 17 * DS9HUD:GetHUDScale(), value);
    DS9HUD:DrawBar(x + math.floor(62 * DS9HUD:GetHUDScale()), y + h - 16 * DS9HUD:GetHUDScale(), HEALTH_BAR, math.min(value * 0.01, 0.9), anim);

    draw.SimpleText("MED", "ds9hud_label", x + HP_W * DS9HUD:GetHUDScale() * 0.628, y + h - math.Round(AP_H * DS9HUD:GetHUDScale() * 0.6), Color(255, 200, 200, 90), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
  end

  --[[
    Draws the shield panel
    @param {number} x
    @param {number} y
  ]]
  function DS9HUD:DrawShield(x, y, value)
    value = value or 0;
    local w, h = AP_W * DS9HUD:GetHUDScale(), AP_H * DS9HUD:GetHUDScale();

    -- Draw body
    surface.SetMaterial(SHIELD_BODY);
    surface.SetDrawColor(Color(255, 255, 255));
    surface.DrawTexturedRect(x, y, w, h);

    -- Draw foreground
    DS9HUD:DrawNumber(x + 30 * DS9HUD:GetHUDScale(), y + h - 17 * DS9HUD:GetHUDScale(), value);
    DS9HUD:DrawBar(x + math.floor(35 * DS9HUD:GetHUDScale()), y + h - 16 * DS9HUD:GetHUDScale(), ARMOUR_BAR, math.min(value * 0.01, 0.9));

    draw.SimpleText("SHIELD", "ds9hud_label", x + AP_W * DS9HUD:GetHUDScale() * 0.445, y + math.Round(AP_H * DS9HUD:GetHUDScale() * 0.4), Color(255, 200, 200, 90), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
  end

  --[[
    Draws the health and armour panel
    @param {number} x
    @param {number} y
  ]]
  function DS9HUD:DrawVitalSignsPanel(x, y)
    y = y - HP_H * DS9HUD:GetHUDScale();

    -- Variables
    local hp, ap = math.max(LocalPlayer():Health(), 0), LocalPlayer():Armor();

    -- Background
    local w = HP_W;
    if (ap > 0) then w = HP_W + AP_W - AP_M; end
    DS9HUD:DrawBackground(x + HP_M * DS9HUD:GetHUDScale(), y, w - HP_M, HP_H - HP_VM);

    -- Foreground
    DS9HUD:DrawHealth(x, y, hp);

    if (ap <= 0) then return; end
    DS9HUD:DrawShield(x + HP_W * DS9HUD:GetHUDScale(), y + (HP_H - AP_H) * DS9HUD:GetHUDScale(), ap);
  end

end
