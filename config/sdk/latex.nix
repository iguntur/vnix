{ config, pkgs, lib, ... }:
{
  plugins.vimtex = {
    enable = true;

    # texliveFull ~ beberapa GB. Alternatif lebih ringan (sesuaikan paket yang kamu butuhkan):
    # texlivePackage = pkgs.texliveMedium;
    # texlivePackage = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-small latexmk biber; };
    texlivePackage = pkgs.texliveFull;

    settings = {
      imaps_enabled = 0;
      view_automatic = 1;

      # Zathura sebagai viewer.
      # "zathura"        -> butuh xdotool/D-Bus untuk fokus window (Linux/X11)
      # "zathura_simple" -> versi sederhana, lebih cocok di macOS / Wayland
      view_method = if pkgs.stdenv.isDarwin then "skim" else "zathura";
      # view_general_viewer = "zathura";
      # view_general_options = "--synctex-forward @line:@col:@tex @pdf";

      # Tidak perlu view_general_viewer / view_general_options:
      # itu hanya dipakai kalau view_method = "general".

      quickfix_open_on_warning = 0;
      quickfix_ignore_filters = [
        "Underfull"
        "Overfull"
        "LaTeX Warning: .\\+ float specifier changed to"
        "Package hyperref Warning: Token not allowed in a PDF string"
      ];

      compiler_latexmk = {
        # Opsional: pisahkan output build dari source
        # build_dir = "build";
        options = [
          "-verbose"
          "-file-line-error"
          "-synctex=1"
          "-interaction=nonstopmode"
          "-shell-escape" # hapus jika tidak memakai minted/pythontex/dll.
        ];
      };
    };
  };

  plugins.lsp.servers.texlab = {
    enable = true;
    settings.texlab = {
      # Kompilasi sudah ditangani vimtex, jangan dobel
      build.onSave = false;
    };
  };

  plugins.conform-nvim.settings.formatters_by_ft = {
    texplain = [ "tex-fmt" ];
    tex = [ "tex-fmt" ];
  };

  extraPackages = with pkgs; [
    tex-fmt
  ]
  ++ lib.optionals pkgs.stdenv.isDarwin [
    # ...
  ]
  ++ lib.optionals pkgs.stdenv.isLinux [
    zathura
  ];
}
