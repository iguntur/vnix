{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.clangd = {
      enable = true;
      # clang-tools membawa clangd + clang-format + clang-tidy dalam satu versi
      # package = pkgs.clang-tools;
      cmd = [
        "clangd"
        "--background-index"
        "--clang-tidy"
        "--header-insertion=iwyu"
        "--completion-style=detailed"
        "--function-arg-placeholders"
        "--fallback-style=llvm"
        "--pch-storage=memory"
        "-j=4"
      ];
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
      };

      # dipakai hanya kalau project tidak punya .clang-format
      formatters.clang_format.prepend_args = [ "--fallback-style=LLVM" ];
    };

    # :ClangdSwitchSourceHeader, AST viewer, type hierarchy
    clangd-extensions.enable = true;

    cmake-tools.enable = true;
  };

  # Switch header/source: .h <-> .cpp
  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>ch";
  #     action = "<cmd>ClangdSwitchSourceHeader<cr>";
  #     options.desc = "Switch source/header";
  #   }
  # ];

  extraPackages = with pkgs; [
    clang-tools # clangd, clang-format, clang-tidy
    cmake
    ninja
    bear # generate compile_commands.json untuk project Makefile
    lldb # debugger (lldb-dap)
    cppcheck # opsional
  ];
}

