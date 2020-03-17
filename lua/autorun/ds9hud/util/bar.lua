--[[------------------------------------------------------------------
  SEGMENT BAR
  Iconic 10 segment bars
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local SEGM_W, SEGM_H = 16, 4;
  local HIGHLIGHT_TEXTURE = Material("ds9hud/bar_red.png");

  --[[
    Draws a bar
    @param {number} x
    @param {number} y
    @param {Material} material
    @param {number|nil} value
    @param {number|nil} highlight
  ]]
  function DS9HUD:DrawBar(x, y, material, value, highlight)
    value = value or 0.9;
    if (value <= 0) then return; end

    if (highlight ~= nil and highlight > 0) then
      surface.SetMaterial(HIGHLIGHT_TEXTURE);
      surface.SetDrawColor(Color(255, 255, 255));

      for i=0, math.max(math.floor(value * 10) - 1, 0) do
        surface.DrawTexturedRect(x, y - math.floor(SEGM_H * DS9HUD:GetHUDScale()) * (i + 1),  math.floor(SEGM_W * DS9HUD:GetHUDScale()), math.floor(SEGM_H * DS9HUD:GetHUDScale()));
      end
    end

    highlight = highlight or 0;
    surface.SetMaterial(material);
    surface.SetDrawColor(Color(255, 255, 255, 255 * (1 - highlight)));

    for i=0, math.max(math.floor(value * 10) - 1, 0) do
      surface.DrawTexturedRect(x, y - math.floor(SEGM_H * DS9HUD:GetHUDScale()) * (i + 1),  math.floor(SEGM_W * DS9HUD:GetHUDScale()), math.floor(SEGM_H * DS9HUD:GetHUDScale()));
    end
    --surface.DrawTexturedRectUV(x, y + math.Round((totalH - h) * DS9HUD:GetHUDScale()), math.Round(SEGM_W * DS9HUD:GetHUDScale()), math.Round(h * DS9HUD:GetHUDScale()), 0, 1 - (math.Round((h/totalH) * 100) * 0.01), 1, 1);
  end

end
