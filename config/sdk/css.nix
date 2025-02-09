{ config, lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      cssls.enable = true;
      tailwindcss = {
        enable = true;
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex";
              eelixir = "html-eex";
              heex = "html-eex";
              templ = "html";
            };
          };
        };
      };
    };

    tailwind-tools = {
      enable = config.plugins.lsp.servers.tailwindcss.enable;
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  extraPackages = with pkgs; [
    rustywind # A tool for formatting Tailwind CSS classes.
  ];
}
