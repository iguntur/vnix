{ config, pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
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
  ++ lib.optionals isDarwin [
    # ...
  ]
  ++ lib.optionals isLinux [
    # ...
  ];
}

