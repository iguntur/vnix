{ pkgs, ... }:
{
  colorschemes = {
    rose-pine = {
      # enable = true;
      settings = {
        dark_variant = "moon";
        dim_inactive_windows = true;
        styles = {
          # bold = false;
          italic = true;
          transparency = true;
        };
        variant = "auto";
      };
    };

    tokyonight = {
      enable = true;
      settings = {
        dim_inactive = true;
        terminal_colors = true;
        transparent = true;
        style = "storm"; # "storm" | "night"
      };
    };
  };
}
