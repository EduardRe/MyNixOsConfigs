{ config, pkgs, ... }:{
	home = {
		username = "ed";
		homeDirectory = "/home/ed";
		stateVersion = "25.05";
	};

	# Включаем dconf для управления настройками GNOME
 	# programs.dconf.enable = true;

  	# Настройка GNOME для переключения раскладок по Shift+Alt
	dconf.settings = {
    	"org/gnome/desktop/input-sources" = {
      		xkb-options = ["grp:alt_shift_toggle"];
    	};
    	"org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
        };
        "org/gnome/settings-daemon/peripherals/keyboard" = {
          numlock-state = true;
          remember-numlock-state = true;
        };
  	};
	
	programs.bash = {
		enable = true;
		shellAliases = {
			rebild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos-configs";
			hmswitch = "home-manager switch --flake ${config.home.homeDirectory}/nixos-configs";
			nixupdate = "sudo nix flake update --flake ${config.home.homeDirectory}/nixos-configs";
		};
	};

	# nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    #    "phpstorm-with-plugins"
    #    "phpstorm"
    # ];

	# Установка плагинов для PhpStorm
    # home.packages = with pkgs; [
    #    (jetbrains.plugins.addPlugins jetbrains.phpstorm [ "Key Promoter X" ])
    # ];
}
