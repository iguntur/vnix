{ config, pkgs, lib, vnix, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  LL = keys: "<localleader>${keys}";
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
    typstyle
    # ...
  ]
  ++ lib.optionals isDarwin [
    # ...
  ]
  ++ lib.optionals isLinux [
    # ...
  ];

  autoGroups.vnix_typst-preview.clear = true;
  autoCmd = [
    {
      event = "FileType";
      group = "vnix_typst-preview";
      pattern = [ "typst" ];
      callback = vnix.lua.fnRaw (vnix.keymap.make [
        {
          mode = "n";
          key = LL (LL "tp");
          action = "<cmd>TypstPreview<cr>";
          options = { silent = true; desc = "Execute TypstPreview"; };
        }
        {
          mode = "n";
          key = LL (LL "ts");
          action = "<cmd>TypstPreviewStop<cr>";
          options = { silent = true; desc = "Execute TypstPreviewStop"; };
        }
      ]);
    }
  ];
}
