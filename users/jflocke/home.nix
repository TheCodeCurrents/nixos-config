{ config, pkgs, inputs, ... }:

{

  imports = [
    ./gnome.nix
  ];

  home.username = "jflocke";
  home.homeDirectory = "/home/jflocke";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # utility
    neofetch

    # productivity
    eza
    fzf
    bat

  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Jakob Flocke";
    userEmail = "jflocke@proton.me";
  };

  # enable zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(zoxide init bash)"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      gcm = "gmit commit -m";
      gst = "git status -sb'";
      gsw = "git switch";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
    };
  };

  # vscode
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
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
