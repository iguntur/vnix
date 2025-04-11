{ config, lib, vnix, ... }:
let
  journal-path = "$HOME/dev/github.com/iguntur/journal";
  workspaces = {
    # Format: <name_of_workspace> = <path_to_workspace_root>
    coding = "${journal-path}/coding";
    personal = "${journal-path}/home";
  };
  workspaceNames = builtins.attrNames workspaces;
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
      "<leader>fj" = {
        action = "files";
        settings = {
          prompt = "❯ ";
          cwd.__raw = ''vim.fn.expand("${journal-path}")'';
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
      key = "<leader>nw";
      action = vnix.keymap.action_fn # lua 
        ''
          require("fzf-lua").fzf_exec(${lib.nixvim.toLuaObject workspaceNames}, {
            winopts = {
              fullscreen = false,
              width = 0.5,
              height = 0.5,
              backgrop = 100,
            },
            fn_selected = function(selected)
              if selected[1] == "enter" then
                vim.cmd([[silent! Neorg workspace ]] .. selected[2])
              end
            end,
          })
        '';
      options = {
        silent = true;
        desc = "Select Neorg workspace";
      };
    }
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
