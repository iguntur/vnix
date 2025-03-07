{ config, pkgs, lib, vnix, ... }:
{
  plugins = {
    lsp.servers.rust_analyzer = {
      # enable = true;
      installCargo = true;
      installRustc = true;
      installRustfmt = true;
    };

    crates = {
      enable = true; # LSP for Cargo.toml
      settings = {
        completion = {
          crates = {
            enabled = true;
          };
        };
        lsp = {
          enabled = true;
          actions = true;
          completion = true;
          hover = true;
        };
      };
    };

    rustaceanvim = {
      enable = !config.plugins.lsp.servers.rust_analyzer.enable;
      settings = {
        server = {
          # standalone = false;
          default_settings = {
            rust-analyzer = {
              files.excludeDirs = [ ".direnv" ".devenv" ".git" "target" ];
              cargo = {
                allFeatures = true;
              };
              check = {
                command = "clippy";
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
            };
          };
          on_attach.__raw = ''
            function(client, bufnr)
              if client.name ~= "rust-analyzer" then
                return
              end

              ${vnix.lsp.onAttach_keymaps [
                {
                  key = "<leader>ca";
                  action = vnix.keymap.action_fn ''
                    vim.cmd.RustLsp("codeAction")
                  '';
                  options.desc = "Rust code action";
                }
                {
                  key = "K";
                  action = vnix.keymap.action_fn ''
                    vim.cmd.RustLsp({"hover", "actions"})
                  '';
                  options.desc = "Rust LSP hover actions";
                }
              ]}

              return _M.lspOnAttach(client, bufnr)
            end
          '';
        };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      rust = [ "rustfmt" ];
    };
  };

  extraPackages = with pkgs; [
    rust-analyzer
    # rustfmt
  ];
}
