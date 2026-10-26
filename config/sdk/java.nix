{ lib, pkgs, ... }:
{
  plugins = {
    java = {
      enable = true;
      # settings = {};
    };

    spring-boot = {
      enable = true;
    };

    lsp.servers = {
      # java_language_server.enable = false;
      jdtls.enable = true;
    };

    # java = { enable = true; };
    # jdtls = {
    #   enable = true;
    # };

    conform-nvim.settings.formatters_by_ft = {
      # java = [ "palantir-java-format" ];
    };
  };

  # extraPackages = with pkgs; [
  # ];
}
