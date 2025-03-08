{ config, lib, vnix, ... }:
let
  workspaces = {
    # Format: <name_of_workspace> = <path_to_workspace_root>
    personal = "~/dev/notes/guntur";
    efishery = "~/dev/notes/efishery";
    ruangguru = "~/dev/notes/ruangguru";
    tictag = "~/dev/notes/tictag";
  };
in
{
  plugins = {
    neorg = {
      enable = true;
      settings = {
        load = {
          "core.defaults" = {
            __empty = null;
          };
          "core.keybinds" = {
            config = {
              default_keybinds = true;
            };
          };

          "core.concealer" = {
            config = {
              icons = {
                code_block = {
                  conceal = true;
                };
              };
              icon_preset = "varied";
            };
          };

          "core.dirman" = {
            config = {
              workspaces = workspaces;
              default_workspace = "personal";
              index = "index.norg"; # The name of the main (root) .norg file
            };
          };
        };
      };
    };

    fzf-lua.keymaps = {
      "<leader>fn" = {
        action = "files";
        settings = {
          prompt = "❯ ";
          cwd.__raw = ''vim.fn.expand("$HOME/dev/notes")'';
        };
        options = {
          silent = true;
          desc = "Neorg notes";
        };
      };
      "<leader>fj" = {
        action = "files";
        settings = {
          prompt = "❯ ";
          cwd.__raw = ''vim.fn.expand("$HOME/dev/journals")'';
        };
        options = {
          silent = true;
          desc = "Journal files";
        };
      };
    };
  };

  keymaps = lib.optionals config.plugins.neorg.enable [
    {
      mode = "n";
      key = "<leader>nr";
      action = "<cmd>Neorg return<cr>";
      options = {
        silent = true;
        desc = "Neorg return";
      };
    }
  ];
}
