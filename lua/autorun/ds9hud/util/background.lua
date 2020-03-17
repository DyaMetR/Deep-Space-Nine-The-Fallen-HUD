--[[------------------------------------------------------------------
  BACKGROUND
  Draw background for elements
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local BACKGROUND_ALPHA = 200;
  local CORNER = Material("ds9hud/bg_corner.png");
  local HORIZONTAL = Material("ds9hud/bg_lat.png");
  local VERTICAL = Material("ds9hud/bg_ver.png");
  local CRN_W, CRN_H = 7, 7;

  --[[
    Draws a background
    @param {number} x
    @param {number} y
    @param {number} w
    @param {number} h
    @param {boolean|nil} is inverted
  ]]
  function DS9HUD:DrawBackground(x, y, w, h, inverted)
    -- Scale sizes
    local crnW, crnH = math.Round(CRN_W * DS9HUD:GetHUDScale()), math.Round(CRN_H * DS9HUD:GetHUDScale());
    w = math.Round(w * DS9HUD:GetHUDScale());
    h = math.floor(h * DS9HUD:GetHUDScale());

    -- Draw corner
    surface.SetMaterial(CORNER);
    surface.SetDrawColor(Color(0, 0, 0, 255));

    if (inverted) then
      surface.DrawTexturedRectUV(x, y, crnW, crnH, 1, 0, 0, 1);
    else
      surface.DrawTexturedRect(x + w - crnW, y, crnW, crnH);
    end

    -- Draw lateral
    surface.SetMaterial(HORIZONTAL);

    if (inverted) then
      surface.DrawTexturedRectUV(x, y + crnH, crnW, math.max(h - crnH, 0), 1, 0, 0, 1);
    else
      surface.DrawTexturedRect(x + w - crnW, y + crnH, crnW, math.max(h - crnH));
    end

    -- Draw top
    surface.SetMaterial(VERTICAL);

    if (inverted) then
      surface.DrawTexturedRect(x + crnW, y, math.max(w - crnW, 0), crnH);
    else
      surface.DrawTexturedRect(x, y, math.max(w - crnW, 0), crnH);
    end

    -- Fill
    if (inverted) then
      draw.RoundedBox(0, x + crnW, y + crnH, w - crnW, h - crnH, Color(0, 0, 0, BACKGROUND_ALPHA));
    else
      draw.RoundedBox(0, x, y + crnH, w - crnW, h - crnH, Color(0, 0, 0, BACKGROUND_ALPHA));
    end
  end

end
