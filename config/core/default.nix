{
  imports = [
    ./keymaps

    ./autocmd.nix
    ./colorschemes.nix
    ./extra-config.nix
    ./options.nix
  ];

  editorconfig.enable = true;
  luaLoader.enable = true;

  # performance = {
  #   # byteCompileLua.enable = true;
  #   # combinePlugins = {
  #   #   enable = true;
  #   #   standalonePlugins = [
  #   #     # "persistent-breakpoints"
  #   #     # "dap"
  #   #   ];
  #   # };
  # };
}
