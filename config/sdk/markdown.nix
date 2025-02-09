{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.marksman.enable = true;

    markdown-preview = {
      enable = true; # command: MarkdownPreview
      settings = { };
    };

    # https://github.com/MeanderingProgrammer/render-markdown.nvim
    render-markdown = {
      enable = true; # command: RenderMarkdown
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        markdown = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          timeout_ms = 2000;
          stop_after_first = true;
        };
      };
    };
  };

  extraPackages = with pkgs; [
    # markdownlint-cli2 # Fast, flexible, configuration-based command-line interface for linting Markdown/CommonMark files with the markdownlint library
    nodePackages.prettier # Prettier is an opinionated code formatter
    prettierd # Prettier, as a daemon, for improved formatting speed
  ];
}
