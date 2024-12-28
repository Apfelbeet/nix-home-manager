{ dotfiles, config, lib, pkgs, ... }:

let cfg = config.programs.t-terminal.alacritty;
in {

  options.programs.t-terminal.alacritty.enable =
    lib.mkEnableOption "Enable alacritty configuration.";

  options.programs.t-terminal.alacritty.package =
    lib.mkPackageOption pkgs "alacritty" {
      default = "alacritty";
      example = "pkgs.unstable.alacritty";
    };

  config = lib.mkIf cfg.enable {

    programs.alacritty = {
      enable = true;
      package = cfg.package;
    };

    home.file = {
      ".config/alacritty/catppuccin-mocha.toml".source = dotfiles
        + "/config/alacritty/catppuccin-mocha.toml";
      ".config/alacritty/alacritty.toml".source = dotfiles
        + "/config/alacritty/alacritty.toml";
      ".config/alacritty/main.toml".source = dotfiles
        + "/config/alacritty/main.toml";
    };
  };
}
