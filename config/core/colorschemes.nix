{ pkgs, ... }:
{
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        dim_inactive = {
          enabled = false; # dims the background color of inactive window
          shade = "dark";
          percentage = 0.9; # percentage of the shade to apply to the inactive window
        };
      };
    };

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
      # enable = true;
      settings = {
        dim_inactive = true;
        terminal_colors = true;
        transparent = true;
        style = "storm"; # "storm" | "night"
      };
    };
  };
}
