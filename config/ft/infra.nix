{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      ansiblels.enable = true;
      dockerls.enable = true;
      terraformls.enable = true;
      helm_ls = {
        enable = true;
        # filetypes = [ "helm" ];
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      # ...
    };
  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-ansible";
      src = pkgs.fetchFromGitHub {
        owner = "mfussenegger";
        repo = "nvim-ansible";
        rev = "44dabdaa8a9193b7f564a8408ed6d7107705030a";
        hash = "sha256-uigPQ6VAXjs52XkYHJMKHxKKwpqnsJmhocsTpMq40ac=";
      };
    })
  ];

  # extraPackages = with pkgs; [
  # ];
}
