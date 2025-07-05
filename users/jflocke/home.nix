{ config, pkgs, inputs, ... }:

{

  imports = [
    ./gnome.nix
    ./terminal.nix
  ];

  home.username = "jflocke";
  home.homeDirectory = "/home/jflocke";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # utility
    neofetch

    # terminal
    eza
    fzf
    bat
    grc

  ];

  programs.git = {
    enable = true;
    userName = "Jakob Flocke";
    userEmail = "jflocke@proton.me";
  };

  # vscode
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Tokyo Night";
        "workbench.iconTheme" = "Catppuccin Macchiato";
        "editor.fontSize" = 15;
      };
      
      extensions = with pkgs.vscode-extensions; [

        visualstudioexptteam.vscodeintellicode

        # python
        ms-python.python
        njpwerner.autodocstring

        # rust
        rust-lang.rust-analyzer
        # dustypomerleau.rust-syntax
        fill-labs.dependi

        # nix
        jnoortheen.nix-ide

        # java
        vscjava.vscode-java-pack

        # C/C++
        ms-vscode.cpptools-extension-pack

        # themes
        zhuangtongfa.material-theme
        catppuccin.catppuccin-vsc
        # whizkydee.material-palenight-theme
        enkia.tokyo-night
        
        # icons
        catppuccin.catppuccin-vsc-icons

        # microschrott
        github.copilot-chat
        github.copilot
      ];
    };
  };
  
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
