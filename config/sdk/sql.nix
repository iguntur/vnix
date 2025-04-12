{ config, lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.sqls = {
      enable = true;
      onAttach.function = /* lua */ ''
        require('sqls').on_attach(client, bufnr)
      '';
      settings = { };
    };
  };

  extraPlugins = lib.optionals config.plugins.lsp.servers.sqls.enable [
    (pkgs.vimUtils.buildVimPlugin {
      name = "sqls";
      src = pkgs.fetchFromGitHub {
        owner = "nanotee";
        repo = "sqls.nvim";
        rev = "main";
        hash = "sha256-bQKO5Kq4Jc8v7d6OSkkzjqYHzt8c5C71xzHHABErlsg=";
      };
    })
  ];
}
