--[[------------------------------------------------------------------
  NUMBERS
  Draw image based numbers
]]--------------------------------------------------------------------

if CLIENT then

  -- Declare fonts
  surface.CreateFont("ds9hud_label", {
    font = "Helvetica Ultra Compressed",
    size = 13 * DS9HUD:GetHUDScale(),
    weight = 0,
    antialias = true,
    additive = true
  });

  surface.CreateFont("ds9hud_weapon", {
    font = "Helvetica Ultra Compressed",
    size = 17 * DS9HUD:GetHUDScale(),
    weight = 0,
    antialias = true,
    additive = true
  });

  -- Parameters
  local NUMBERS_TEXTURE = surface.GetTextureID("ds9hud/numbers");
  local FILE_W, FILE_H = 128, 16;
  local NUM_W, NUM_H = 7, 14;

  --[[
    Draws a number at the given position
    @param {number} x
    @param {number} y
    @param {number} number
    @param {boolean|nil} should it be centered
  ]]
  function DS9HUD:DrawNumber(x, y, number, centered)
    if (centered) then
      x = x - NUM_W * DS9HUD:GetHUDScale() * string.len(tostring(number)) * 0.5;
    else
      x = x - NUM_W * DS9HUD:GetHUDScale() * string.len(tostring(number));
    end
    y = y - NUM_H * DS9HUD:GetHUDScale();

    surface.SetTexture(NUMBERS_TEXTURE);
    surface.SetDrawColor(Color(255, 255, 255));

    local w, h = NUM_W * DS9HUD:GetHUDScale(), NUM_H * DS9HUD:GetHUDScale();
    for i, num in pairs(string.Explode("", tostring(number))) do
      local u1, v1, u2, v2 = (NUM_W * tonumber(num)) / FILE_W, 0, (NUM_W * (tonumber(num) + 1)) / FILE_W, 1;
      surface.DrawTexturedRectUV(x + math.Round(NUM_W * i * DS9HUD:GetHUDScale()) - math.Round(w * 0.5), y, math.Round(w), math.Round(h), u1, v1, u2, v2);
    end
  end

end
