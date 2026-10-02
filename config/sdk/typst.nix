{ config, pkgs, lib, ... }:
{
  plugins.typst-preview = {
    enable = true;
    # settings = { };
  };

  plugins.lsp.servers.tinymist = {
    enable = true;
    # config = {
    #   settings = { };
    # };
  };

  extraPackages = with pkgs; [
    # ...
  ]
  ++ lib.optionals pkgs.stdenv.isDarwin [
    # ...
  ]
  ++ lib.optionals pkgs.stdenv.isLinux [
    # ...
  ];
}

