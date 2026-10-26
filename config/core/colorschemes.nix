{ pkgs, ... }:
{
  # colorscheme = "habamax";

  colorschemes = {
    ayu = {
      enable = true;
      settings = {
        overrides = {
          Normal = { bg = "None"; };
          NormalFloat = { bg = "None"; };
          # ColorColumn = { bg = "None"; };
          # SignColumn = { bg = "None"; };
          # Folded = { bg = "None"; };
          # FoldColumn = { bg = "None"; };
          # CursorLine = { bg = "None"; };
          # CursorColumn = { bg = "None"; };
          # VertSplit = { bg = "None"; };
        };
      };
    };

    catppuccin = {
      # enable = true;
      settings = {
        transparent_background = true;
        dim_inactive = {
          enabled = false; # dims the background color of inactive window
          shade = "dark";
          percentage = 0.9; # percentage of the shade to apply to the inactive window
        };
      };
    };

    palette = {
      # enable = true;
      settings = {
        transparent_background = false;
        # palettes = {
        #   main = "dark"; # dark or light
        #   # pastel, bright or dark
        #   accent = "dark";
        #   state = "dark";
        # };
      };
    };

    nightfox = {
      # enable = true;
      flavor = "carbonfox"; # Type: one of “carbonfox”, “dawnfox”, “dayfox”, “duskfox”, “nightfox”, “nordfox”, “terafox”
      settings = {
        options = {
          transparent = true;
        };
      };
    };

    vague = {
      # enable = true;
      settings = {
        # transparent = true;
      };
    };

    rose-pine = {
      # enable = false;
      settings = {
        variant = "main"; # auto, main, moon, dawn
        dark_variant = "main"; # auto, main, moon, dawn
        dim_inactive_windows = false;
        styles = {
          bold = true;
          italic = true;
          transparency = true;
        };
      };
    };

    tokyonight = {
      # enable = true;
      settings = {
        dim_inactive = false;
        terminal_colors = true;
        transparent = true;
        style = "storm"; # "storm" | "night"
      };
    };
  };
}
