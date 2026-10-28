{ config, lib, ... }:
let
  inherit (lib.nixvim) mkRaw;
  enabled = name: config.plugins.${name}.enable or false;
  loader = "require('mini.snippets').gen_loader";
in
{
  plugins = {
    friendly-snippets.enable = true;

    mini.enable = true; # abaikan jika sudah diset di file lain
    mini.modules.snippets.snippets =
      # Snippet global dari friendly-snippets
      lib.optional (enabled "friendly-snippets")
        (
          mkRaw "${loader}.from_file('${config.plugins.friendly-snippets.package}/snippets/global.json')"
        )
      ++ lib.optional (enabled "friendly-snippets") (
        mkRaw "${loader}.from_file('~/dev/github.com/iguntur/vnix/snippets/java.json')"
      )
      # Snippet per filetype dari runtimepath: snippets/<lang>.json
      ++ [ (mkRaw "${loader}.from_lang()") ];
  };

  # Masuk ke runtimepath sebagai snippets/java.json, jadi hanya aktif di filetype java.
  # extraFiles."snippets/java.json".source = ../../snippets/java.json;
}
