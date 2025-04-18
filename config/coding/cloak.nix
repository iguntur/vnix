{ lib, pkgs, ... }:
{
  plugins = {
    cloak = {
      enable = true;
      settings = {
        enabled = true;
        cloak_character = "*";
        highlight_group = "Comment";
        patterns = [
          {
            cloak_pattern = "=.+";
            file_pattern = [
              ".env"
              ".env.*"
              "*.env"
              ".*.env"
              # "*.toml"
            ];
          }
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<localleader>e";
      action = "<cmd>CloakToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Cloak Env Secret";
      };
    }
  ];
}
