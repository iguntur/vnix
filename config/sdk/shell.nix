{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      bashls = {
        enable = true;
        settings = {
          filetypes = [ "sh" "bash" ];
          bashIde = {
            shellcheckArguments = [
              "--exclude=SC2034"
            ];
          };
        };
      };
      # nushell.enable = true;
    };

    conform-nvim.settings.formatters_by_ft = {
      bash = [ "shellcheck" "shellharden" "shfmt" ];
      sh = [ "shellcheck" "shellharden" "shfmt" ];
    };
  };

  extraPackages = with pkgs; [
    shellcheck # Shell script analysis tool
    shellharden # Corrective bash syntax highlighter
    shfmt # Shell parser and formatter
  ];
}
