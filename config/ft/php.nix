{ lib, pkgs, vnix, ... }:
{
  plugins = {
    lsp.servers = {
      # intelephense = {
      #   enable = true;
      #   package = pkgs.intelephense;
      # };
      phpactor.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      php = [
        "pint"
        "rustywind"
      ];
    };
  };

  extraPackages = with pkgs; [
    php84 # HTML-embedded scripting language
    # php84Packages.composer # Dependency Manager for PHP
    # pint
  ];
}
