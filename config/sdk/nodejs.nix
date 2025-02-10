{ config, lib, pkgs, vnix, ... }:
{
  plugins = {
    package-info = {
      enable = true;
      settings = { };
      lazyLoad.settings = {
        event = [
          "LspAttach"
          # "BufEnter package.json"
        ];
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };

    lsp.servers.jsonls.onAttach.function = lib.optionals config.plugins.package-info.enable (
      vnix.lsp.onAttach_keymaps [
        {
          key = "<localleader>pt";
          action.__raw = "require('package-info').toggle";
          options.desc = "Toggle dependency version";
        }
        {
          key = "<localleader>pv";
          action.__raw = "require('package-info').change_version";
          options.desc = "Bump dependency version";
        }
      ]
    );
  };

  # extraPackages = with pkgs; [
  # ];
}
