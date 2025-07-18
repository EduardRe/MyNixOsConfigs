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
  	};
	
	programs.bash = {
		enable = true;
		shellAliases = {
			rebild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos-configs";
			hmswitch = "home-manager switch --flake ${config.home.homeDirectory}/nixos-configs";
		};
	};
}
