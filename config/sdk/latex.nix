{ config, pkgs, lib, ... }:
{
  plugins.texpresso.enable = true;

  plugins.vimtex = {
    enable = true;
    texlivePackage = pkgs.texlivePackages.scheme-full; # Default: pkgs.texlive.combined.scheme-medium
    settings = {
      imaps_enabled = 0; # i.e., disable them
      view_enabled = true;
      # TODO: use zathura
      view_method = "skim"; # change this, depending on what you want to use..sumatraPDF, or skim, or zathura, or...
      # view_general_viewer = "zathura";
      view_general_options = "-reuse-instance -forward-search @tex @line @pdf";
      # view_general_options = "--synctex-forward @line:@col:@tex @pdf";
      quickfix_open_on_warning = 0; # don't open quickfix if there are only warnings
      quickfix_ignore_filters = [
        "Underfull"
        "Overfull"
        "LaTeX Warning: .\\+ float specifier changedto"
        "Package hyperref Warning: Token not allowed in a PDF string"
      ];
    };
  };

  plugins.lsp.servers = {
    texlab = {
      enable = true;
      settings = { };
    };
  };

  plugins.conform-nvim.settings.formatters_by_ft = {
    texplain = [ "tex-fmt" ];
    tex = [ "tex-fmt" ];
  };

  extraPackages = with pkgs; [
    tex-fmt
    # texlive.combined.scheme-full
    # texlive.moderncv
    # latexrun
    # tectonic
  ];
}
