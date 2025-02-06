{ config, lib, pkgs, vnix, ... }:
let
  treesitter-blade-grammar = pkgs.tree-sitter.buildGrammar rec {
    language = "blade";
    version = "0.11.0";
    src = pkgs.fetchFromGitHub {
      owner = "EmranMR";
      repo = "tree-sitter-blade";
      rev = "v${version}";
      hash = "sha256-PTGdsXlLoE+xlU0uWOU6LQalX4fhJ/qhpyEKmTAazLU=";
    };
    meta.homepage = "https://github.com/EmranMR/tree-sitter-blade";
  };
in
{
  filetype.pattern = {
    ".*%.blade%.php" = "blade";
  };

  plugins = {
    lsp.servers = { };

    conform-nvim.settings.formatters_by_ft = {
      blade = [
        "blade-formatter"
        "rustywind"
      ];
    };

    treesitter = {
      grammarPackages = [ treesitter-blade-grammar ];
      luaConfig.post = ''
        do
          local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
          parser_config.blade = ${lib.nixvim.toLuaObject {
            filetype = "blade";
            install_info = {
              files = [ "src/parser.c" ];
              url = treesitter-blade-grammar;
            };
          }}
        end
      '';
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "blade-nav";
        ft = [ "php" "blade" ];
        after = # lua
          ''
            function()
              require("blade-nav").setup()
            end
          '';
      }
    ];
  };

  extraPlugins = [
    treesitter-blade-grammar

    # Laravel Blade Nav: Goto File (gf)
    (pkgs.vimUtils.buildVimPlugin {
      name = "blade-nav";
      src = pkgs.fetchFromGitHub {
        owner = "RicardoRamirezR";
        repo = "blade-nav.nvim";
        rev = "56601aaf230698388ed687d1d9d468599d277ac2";
        hash = "sha256-JMRASTwennR0ZgT/DSfA5YTrkgdYjynM21c1zZfYSW4=";
      };
      dependencies = with pkgs.vimPlugins; [
        nvim-treesitter
      ];
    })
  ];

  # extraConfigLua = vnix.lua.mkRequire "blade-nav" "setup";

  extraPackages = with pkgs; [
    blade-formatter # Laravel Blade template formatter
  ];
}
