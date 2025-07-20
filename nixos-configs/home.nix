{ config, pkgs, ... }:
{
  # Настройки home-manager для пользователя ed
  home = {
    username = "ed";
    homeDirectory = "/home/ed";
    stateVersion = "25.05";
  };

  # Установка расширений GNOME
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.just-perfection
  ];

  # Настройка GNOME: раскладки, кнопки окон, Dash to Panel и скрытие верхней панели
  dconf.settings = {
    # Раскладки клавиатуры
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["grp:alt_shift_toggle"];
    };
    # Кнопки в заголовках окон
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };
    # Включение расширений
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "hidetopbar@mathieu.bidon.ca"
      ];
    };
    # Настройка Dash to Panel
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-position = "BOTTOM";
      multi-monitors = true;
      panel-sizes = "{\"0\": 32}"; # Размер панели (32 пикселя)
      appicon-margin = 8;
      animate-show-apps = true;
      show-applications-button = true;
      show-show-apps-button = true;
      show-activities-button = false;
      trans-use-custom-opacity = true;
      trans-panel-opacity = 0.8;
      # Настройка меню приложений
      app-menu-size = 400; # Ширина меню (в пикселях, можно настроить под себя)
      app-menu-position = "LEFT"; # Меню открывается слева
      app-menu-show-all-apps = true; # Показывать все приложения в меню
      app-menu-pinned-apps = []; # Очищаем закреплённые приложения (можно добавить свои)
      app-menu-use-custom-style = true; # Включить кастомный стиль меню
      app-menu-opacity = 0.9; # Прозрачность меню
      window-preview-size = 150;
      isolate-monitors = true;
      isolate-workspaces = true;
      hide-overview-on-startup = true;
    };
    # Скрытие верхней панели GNOME
    "org/gnome/shell/extensions/just-perfection" = {
      panel = false;
    };
  };

  # Настройки bash с алиасами
  programs.bash = {
    enable = true;
    shellAliases = {
      rebild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos-configs";
      hmswitch = "home-manager switch --flake ${config.home.homeDirectory}/nixos-configs";
      nixupdate = "nix flake update --flake ${config.home.homeDirectory}/nixos-configs";
    };
  };
}