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
    # see: https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/neovim/Configuration.md
    settings = {
      formatterMode = "typstyle";
      # exportPdf = "onSave";
      # formatterProseWrap = true;
    };
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

