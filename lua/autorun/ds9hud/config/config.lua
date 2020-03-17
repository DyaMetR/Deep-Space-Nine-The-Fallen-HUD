--[[------------------------------------------------------------------
  CONFIGURATION
  Not much to see here, only a checkbox to toggle the HUD
]]--------------------------------------------------------------------

if CLIENT then
  -- ConVar
  local enabled = CreateClientConVar("ds9hud_enabled", 1, true);
  local weaponName = CreateClientConVar("ds9hud_weapon_names", 0, true);
  local clip = CreateClientConVar("ds9hud_clip", 1, true);

  --[[
    Is the HUD enabled
    @return {boolean} enabled
  ]]
  function DS9HUD:IsEnabled()
    return enabled:GetInt() >= 1;
  end

  --[[
    Whether the weapon panel should show weapon names instead of icons
    @return {boolean} show weapon names
  ]]
  function DS9HUD:ShowWeaponNames()
    return weaponName:GetInt() >= 1;
  end

  --[[
    Should the ammunition indicator be Clip/Reserve/Alt formatted
    @return {boolean} show clip
  ]]
  function DS9HUD:ShouldUseClips()
    return clip:GetInt() >= 1;
  end

  --[[
    Returns the HUD scale
    @param {number} scale
  ]]
  function DS9HUD:GetHUDScale()
    return ScrH() / 640;
  end

  --[[
    Client only options
  ]]
  local function clientOptions( panel )
  	panel:ClearControls();

    panel:AddControl( "CheckBox", {
      Label = "Enabled",
      Command = "ds9hud_enabled",
      }
    );

    panel:AddControl( "CheckBox", {
      Label = "Use weapon names instead of icons",
      Command = "ds9hud_weapon_names",
      }
    );

    panel:AddControl( "CheckBox", {
      Label = "Show clip ammunition separately",
      Command = "ds9hud_clip",
      }
    );

    -- Credits
    panel:AddControl( "Label",  { Text = ""});
    panel:AddControl( "Label",  { Text = "Version " .. DS9HUD.Version});
  end

  --[[
    Add options to the Q menu
  ]]
  local function menuCreation()
  	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "ds9hud", "DS9: The Fallen HUD", "", "", clientOptions );
  end
  hook.Add( "PopulateToolMenu", "ds9hud_menu", menuCreation );
end
