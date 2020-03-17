--[[------------------------------------------------------------------
  AMMUNITION INDICATOR
  Ammunition indicator with weapon icon
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local NULL_WEAPON = surface.GetTextureID("ds9hud/icons/unarmed");
  local NW_W, NW_H = 64, 32;
  local WEAPON_BODY = Material("ds9hud/weapon_body.png");
  local ALT_BODY = Material("ds9hud/extension.png");
  local WEP_W, WEP_H, WEP_M, WEP_VM = 126, 62, 32, 11;
  local ALT_W, ALT_H, ALT_M = 61, 12, 10;
  local RESV_W, RESV_H = 48, 12;
  local COLOUR, COLOUR_BG = Color(100, 16, 141), Color(61, 13, 88);
  local LABEL_CLIP, LABEL_RESERVE, LABEL_ALT = "WEAPON", "RESERVE", "ALT";

  --[[
    Draws the ammunition in clip indicator
    @param {number} x
    @param {number} y
    @param {number} value to display
  ]]
  function DS9HUD:DrawClip(x, y, value)
    value = value or 0;
    local w, h = WEP_W * DS9HUD:GetHUDScale(), WEP_H * DS9HUD:GetHUDScale();

    -- Draw body
    surface.SetDrawColor(Color(255, 255, 255, 255));
    surface.SetMaterial(WEAPON_BODY);
    surface.DrawTexturedRect(x, y, w, h);

    draw.SimpleText(LABEL_CLIP, "ds9hud_label", x + (w * 0.366), y + h - (ALT_H * DS9HUD:GetHUDScale() * 0.55), Color(255, 200, 200, 90), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    -- Draw numbers
    if (value <= -1) then return; end
    DS9HUD:DrawNumber(x + 44 * DS9HUD:GetHUDScale(), y + h - 17 * DS9HUD:GetHUDScale(), value, true);
  end

  --[[
    Draw reserve ammunition indicator
    @param {number} x
    @param {number} y
    @param {number|nil} value to display
    @param {string|nil} label
    @param {boolean} has weapon alternate ammunition
  ]]
  function DS9HUD:DrawReserve(x, y, value, label, hasAlt)
    label = label or LABEL_RESERVE;
    value = value or 0;

    local offset = ALT_W * DS9HUD:GetHUDScale() * 0.543;
    if (hasAlt) then
      offset = RESV_W * DS9HUD:GetHUDScale() * 0.5;
      x = x - math.Round((RESV_W + 3) * DS9HUD:GetHUDScale());
      y = y - math.Round(RESV_H * DS9HUD:GetHUDScale());

      draw.RoundedBox(0, x, y, math.Round(RESV_W * DS9HUD:GetHUDScale()), RESV_H * DS9HUD:GetHUDScale(), COLOUR_BG);
      draw.RoundedBox(0, x + DS9HUD:GetHUDScale(), y + DS9HUD:GetHUDScale(), math.Round((RESV_W - 2) * DS9HUD:GetHUDScale()), (RESV_H - 2) * DS9HUD:GetHUDScale(), COLOUR);
    else
      x = x - math.floor(ALT_W * DS9HUD:GetHUDScale());
      y = y - math.Round(ALT_H * DS9HUD:GetHUDScale());

      surface.SetDrawColor(Color(255, 255, 255));
      surface.SetMaterial(ALT_BODY);
      surface.DrawTexturedRectUV(x, y, ALT_W * DS9HUD:GetHUDScale(), ALT_H * DS9HUD:GetHUDScale(), 1, 0, 0, 1);
    end

    draw.SimpleText(label, "ds9hud_label", x + offset, y + (ALT_H * DS9HUD:GetHUDScale() * 0.454), Color(255, 200, 200, 90), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    DS9HUD:DrawNumber(x + offset - 2.75 * DS9HUD:GetHUDScale(), y + (ALT_H - 17) * DS9HUD:GetHUDScale(), value, true);
  end

  --[[
    Draws alternative fire mode ammunition
    @param {number} x
    @param {number} y
    @param {number|nil} value to display
    @param {string|nil} label
  ]]
  function DS9HUD:DrawAlt(x, y, value, label)
    label = label or LABEL_ALT;
    value = value or 0;
    x = x - math.Round(ALT_W * DS9HUD:GetHUDScale());
    y = y - math.Round(ALT_H * DS9HUD:GetHUDScale());

    surface.SetDrawColor(Color(255, 255, 255));
    surface.SetMaterial(ALT_BODY);
    surface.DrawTexturedRectUV(x, y, ALT_W * DS9HUD:GetHUDScale(), ALT_H * DS9HUD:GetHUDScale(), 1, 0, 0, 1);

    draw.SimpleText(label, "ds9hud_label", x + ALT_W * DS9HUD:GetHUDScale() * 0.543, y + (ALT_H * DS9HUD:GetHUDScale() * 0.454), Color(255, 200, 200, 90), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    DS9HUD:DrawNumber(x + ALT_W * 0.5 * DS9HUD:GetHUDScale(), y + (ALT_H - 17) * DS9HUD:GetHUDScale(), value, true);
  end

  --[[
    Draws the weapon icon
    @param {number} x
    @param {number} y
    @param {Weapon|NULL} weapon
  ]]
  function DS9HUD:DrawWeaponIcon(x, y, weapon)
    if (IsValid(weapon)) then
      if (DS9HUD:HasWeaponIcon(weapon:GetClass())) then
        local icon = DS9HUD:GetWeaponIcon(weapon:GetClass());
        local w, h = icon.w * 0.815 * DS9HUD:GetHUDScale(), icon.h * 0.815 * DS9HUD:GetHUDScale();
        surface.SetTexture(icon.texture);
        surface.SetDrawColor(Color(255, 255, 255, 180));
        for i=1, 2 do
          surface.DrawTexturedRect(x - w * 0.59, y - h * 0.78, w, h);
        end
      else
        if (weapon:IsScripted() and weapon.DrawWeaponSelection ~= nil) then
          local w, h = 64 * DS9HUD:GetHUDScale() * 1.04, 32 * DS9HUD:GetHUDScale() * 1.04;
          local bounce = weapon.BounceWeaponIcon;
          local info = weapon.DrawWeaponInfoBox;
          weapon.BounceWeaponIcon = false;
          weapon.DrawWeaponInfoBox = false;
          weapon:DrawWeaponSelection(x - w * 0.74, y - h * 1.08, w, h);
          weapon.BounceWeaponIcon = bounce;
          weapon.DrawWeaponInfoBox = info;
        end
      end
    else
      local w, h = NW_W * DS9HUD:GetHUDScale() * 1.63, NW_H * DS9HUD:GetHUDScale() * 1.63;
      surface.SetTexture(NULL_WEAPON);
      surface.SetDrawColor(Color(255, 255, 255));
      surface.DrawTexturedRect(x - w * 0.59, y - h * 0.78, w, h);
    end
  end

  --[[
    Draws the weapon indicator panel
    @param {number} x
    @param {number} y
  ]]
  function DS9HUD:DrawWeaponPanel(x, y)
    x = x - math.Round(WEP_W * DS9HUD:GetHUDScale());
    y = y - math.Round(WEP_H * DS9HUD:GetHUDScale());

    -- Variables
    local clip, reserve, alt = -1, -1, -1;
    local weapon = LocalPlayer():GetActiveWeapon();
    if (IsValid(weapon)) then
      if (weapon:GetPrimaryAmmoType() > 0 or weapon:GetSecondaryAmmoType() > 0) then
        if (weapon:GetPrimaryAmmoType() <= 0) then
          clip = LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType());
        else
          if (weapon:Clip1() > -1) then
            if (DS9HUD:ShouldUseClips()) then
              clip = weapon:Clip1();
              reserve = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType());
            else
              clip = weapon:Clip1() + LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType());
            end
          else
            clip = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType());

            if (weapon:GetSecondaryAmmoType() > 0) then
              reserve = LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType());
            end
          end

          if (weapon:GetSecondaryAmmoType() > 0) then
            alt = LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType());
          end
        end
      else
        if (weapon:Clip1() > -1 and weapon:IsScripted()) then clip = weapon:Clip1(); end
      end
    end

    -- Background
    local offset = ALT_W - ALT_M;
    if (alt > -1 and reserve > -1) then offset = offset * 2; end
    if (reserve <= -1 and alt <= -1) then offset = 0; end

    local w = WEP_W + offset;
    DS9HUD:DrawBackground(x - (offset * DS9HUD:GetHUDScale()), y, w - WEP_M, WEP_H - WEP_VM, true);

    -- Foreground
    if (DS9HUD:ShowWeaponNames()) then
      draw.SimpleText(weapon:GetPrintName(), "ds9hud_weapon", x + (WEP_W * DS9HUD:GetHUDScale() * 0.366), y + (WEP_H * DS9HUD:GetHUDScale() * 0.28), Color(235, 180, 30), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    else
      DS9HUD:DrawWeaponIcon(x + (WEP_W * DS9HUD:GetHUDScale() * 0.5), y + (WEP_H * DS9HUD:GetHUDScale() * 0.5), weapon);
    end

    DS9HUD:DrawClip(x, y, clip);

    if (reserve > -1) then
      DS9HUD:DrawReserve(x, y + (WEP_H * DS9HUD:GetHUDScale()), reserve, nil, alt > -1);
    elseif (alt > -1) then
      DS9HUD:DrawReserve(x, y + (WEP_H * DS9HUD:GetHUDScale()), 0, LABEL_ALT);
    end

    if (alt <= -1 or reserve <= -1) then return; end
    DS9HUD:DrawAlt(x - ((ALT_W - ALT_M) * DS9HUD:GetHUDScale()), y + (WEP_H * DS9HUD:GetHUDScale()), alt);
  end

end
