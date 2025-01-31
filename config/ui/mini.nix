{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # Mini modules
    # --------------------------------------------------------------------------------
    mini.mockDevIcons = true;
    mini.modules = {
      hipatterns = { };
      icons = {
        file = {
          ".keep" = { glyph = "󰊢"; hl = "MiniIconsGrey"; };
          "devcontainer.json" = { glyph = ""; hl = "MiniIconsAzure"; };
          ".eslintrc.js" = { glyph = "󰱺"; hl = "MiniIconsYellow"; };
          ".node-version" = { glyph = ""; hl = "MiniIconsGreen"; };
          ".prettierrc" = { glyph = ""; hl = "MiniIconsPurple"; };
          ".yarnrc.yml" = { glyph = ""; hl = "MiniIconsBlue"; };
          "eslint.config.js" = { glyph = "󰱺"; hl = "MiniIconsYellow"; };
          "package.json" = { glyph = ""; hl = "MiniIconsGreen"; };
          "tsconfig.json" = { glyph = ""; hl = "MiniIconsAzure"; };
          "tsconfig.build.json" = { glyph = ""; hl = "MiniIconsAzure"; };
          "yarn.lock" = { glyph = ""; hl = "MiniIconsBlue"; };
        };
        filetype = {
          dotenv = { glyph = ""; hl = "MiniIconsYellow"; };
        };
      };

      indentscope = {
        # symbol = "▏";
        symbol = "│";
        options = {
          try_as_border = true;
        };
        mappings = {
          # Motions (jump to respective border line; if not present - body line)
          goto_top = "[o";
          goto_bottom = "]o";
        };
      };
    };
  };

  autoCmd = [
    # --------------------------------------------------------------------------------
    # Event: mini indent scope
    # --------------------------------------------------------------------------------
    {
      event = [ "FileType" ];
      callback.__raw = ''
        function()
          vim.b.miniindentscope_disable = true
        end 
      '';
      pattern = [
        "NvimTree"
        "Trouble"
        "alpha"
        "dashboard"
        "fzf"
        "help"
        "mason"
        "neo-tree"
        "notify"
        "snacks_dashboard"
        "snacks_notif"
        "snacks_terminal"
        "snacks_win"
        "toggleterm"
        "trouble"
      ];
    }
  ];
}
