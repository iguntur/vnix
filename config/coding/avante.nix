{ config, lib, pkgs, ... }:
{
  plugins.avante = {
    enable = true;
    settings = {
      # auto_suggestions_frequency = "claude";
      # provider = "claude"; # The LLM provider ("claude", "openai", "azure", …)
    };
  };

  plugins.which-key.settings.spec = lib.optionals config.plugins.avante.enable [
    {
      __unkeyed-1 = "<leader>a";
      group = "AI";
      icon = "󰨈 ";
    }
  ];

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>...";
  #     action = "<cmd>...<cr>";
  #     options = {
  #       silent = true;
  #       desc = "...";
  #     };
  #   }
  # ];
}
