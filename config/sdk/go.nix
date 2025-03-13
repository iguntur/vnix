{ lib, pkgs, vnix, ... }:
let
  json2struct = (pkgs.buildGoModule rec {
    pname = "json2struct";
    version = "2.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "yudppp";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-bg1uyt2hhKOHQe/AZCLPauA5AhyvsPZv6l6zpWc7Pco=";
    };
    vendorHash = "sha256-haaVGKax8K+jMbSi9WYI7eKy0qAbRVS3XpftQ7UhuQk=";
    subPackages = [ "cmd/json2struct" ];
    meta = {
      description = "Translate to Golang struct from json";
      mainProgram = "json2struct";
      homepage = "https://github.com/yudppp/json2struct";
      license = lib.licenses.mit;
    };
  });
in
{
  plugins = {
    # ------------------------------------------------------------------------------
    # LSP
    # ------------------------------------------------------------------------------
    lsp.servers = {
      golangci_lint_ls.enable = true;
      gopls = {
        enable = true;
        filetypes = [ "go" "gomod" "gowork" "gosum" "gotmpl" ];
        goPackage = pkgs.go_1_24;
        settings.gopls = {
          gofumpt = true;
          completeUnimported = true;
          directoryFilters = [ "-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules" ];
          semanticTokens = true;
          staticcheck = true;
          usePlaceholders = true;
          analyses = {
            # fieldalignment = true;
            nilness = true;
            unusedparams = true;
            unusedwrite = true;
            useany = true;
          };
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
        };
        onAttach.function =
          # TODO: workaround: https://github.com/golang/go/issues/54531#issuecomment-1464982242
          # lua
          ''
            if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenModifiers = semantic.tokenModifiers,
                  tokenTypes = semantic.tokenTypes,
                },
                range = true,
              }
            end
          '';
      };
    };

    # ------------------------------------------------------------------------------
    # Formatters
    # ------------------------------------------------------------------------------
    conform-nvim.settings = {
      formatters_by_ft = {
        go = [
          "gofumpt"
          "goimports-reviser"
          "golines"
        ];
      };
      formatters = {
        golines = {
          prepend_args = [ "--max-len=120" ];
        };
      };
    };

    # ------------------------------------------------------------------------------
    # Test adapters
    # ------------------------------------------------------------------------------
    neotest.adapters = {
      golang = {
        enable = true;
        settings = {
          # go_test_args = [ "-v" "-race" "-count=1" "-timeout=60s" ]; # default
          dap_go_enabled = true;
        };
      };
    };

    # ------------------------------------------------------------------------------
    # Debug
    # ------------------------------------------------------------------------------
    dap-go = {
      enable = true;
      settings = {
        # delve = { };
      };
    };
  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "gopher";
      src = pkgs.fetchFromGitHub {
        owner = "olexsmir";
        repo = "gopher.nvim";
        rev = "0ed14a40d9799ac8d92aaf9eb1cd9be22ffd6b14";
        hash = "sha256-5UpNPRh4YdAtpiFTazqCSLeJ0TMmPCm8lVyNFsIJ3lE=";
      };
      dependencies = with pkgs.vimPlugins; [
        plenary-nvim
        nvim-treesitter
        nvim-dap
      ];
    })

    (pkgs.vimUtils.buildVimPlugin {
      name = "json2struct";
      src = pkgs.fetchFromGitHub {
        owner = "triarius";
        repo = "json2struct.nvim";
        rev = "f3d99ab6e02772bcdeb5c1097f75e0d5814bf28b";
        hash = "sha256-pOebbEOkoQb0QuaOP6kKuY5F5YVbyncUCM20JXoqsMI=";
      };
      dependencies = with pkgs.vimPlugins; [ plenary-nvim ];
    })
  ];

  extraConfigLua = lib.strings.concatStringsSep "\n" [
    (vnix.lua.mkRequire "gopher" "setup")
    (vnix.lua.mkRequire "json2struct" "setup")
  ];

  extraPackages = with pkgs; [
    go_1_24 # Go Programming language
    delve # debugger for the Go programming language

    # Linter
    golangci-lint
    # golangci-lint-langserver

    # Formatters
    gofumpt # Stricter gofmt
    goimports-reviser # Right imports sorting & code formatting tool (goimports alternative)
    golines # Golang formatter that fixes long lines

    # Gopher
    gomodifytags # Go tool to modify struct field tags
    gotests # Generate Go tests from your source code
    iferr # Generate "if err != nil {" block
    impl # Generate method stubs for implementing an interface
    json2struct # Translate to Golang struct from json
  ];
}
