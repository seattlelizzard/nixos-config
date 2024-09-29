{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "lizz";
  home.homeDirectory = "/home/lizz";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them 
    
    #Terminal & Shell
    fish
    oh-my-fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    kitty
    tmux

    
    #Terminal Apps
    neofetch
    yazi #better terminal file manager
    lazygit
     

    #GUI apps
    blender
    steam 
    chromium
    vesktop



    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fpp #I'm pretty sure this is fb path picker 
    fd #Alternative to find 
    
    ## email
    isync
    notmuch
    
    ## text editors!
    helix
    nvim-pkg
    mermaid-cli #flowcharter that integrates with emacs -- move to emacs flake.
    emacs

    #IRC
    weechat
    
    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    asciiquarium
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    xclip #clip board cut/copy/paste

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # Physics n math stuffs--consider making flake
    geant4

    #Stuff I'm pretty sure is covered/required by my nvim flake
    #but I am not trying to break things at this step yet. 
    
    zulu
    luajit
    lua-language-server
    julia-lts
    pyright
    ruff
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pynvim
    ]))
    libgccjit
    nodejs_22
    yarn
    go
    delve
    php
    cargo
    
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Lizz";
    userEmail = "seattlelizzard@gmail.com";
  };



  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greetinads
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugins
    ];
  };
  
  programs.neovim.finalPackage = {
    enable = true;
    defaultEditor = true;
  };
  

  programs.tmux = {
  enable = true;
  clock24 = true;
  extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
  

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
