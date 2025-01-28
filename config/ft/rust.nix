{ pkgs, lib, ... }:
{
  plugins = {
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
      enable = true;
      settings = {
        # TODO: complete config
        # - neotest adapters integration
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      rust = [ "rustfmt" ];
    };
  };

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>...";
  #     action = "<cmd>...<cr>";
  #     options = {
  #       silent = true;
  #       desc = "...";
  #     };
  #   }
  # ];
}
