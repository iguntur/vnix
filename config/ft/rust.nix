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
