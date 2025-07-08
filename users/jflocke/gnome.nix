# gnome.nix
{ config, pkgs, lib, ... }:

let
  # alias packages for readability
  papirus = pkgs.papirus-icon-theme;
  palenight = pkgs.palenight-theme;
  numix = pkgs.numix-cursor-theme;
in {
  # Enable GTK and apply themes
  gtk = {
    enable = true;

    theme = {
      name = "palenight";
      package = palenight;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = numix;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  dconf.settings = {
    # ...
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];
    };
  };

  # Make sure the GTK theme variable is set in the session
  home.sessionVariables.GTK_THEME = "palenight";
}
