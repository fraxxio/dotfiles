# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vilnius";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "lt_LT.UTF-8/UTF-8" ];
  };


  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];

  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland = {
      enable = true;
    };
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker = {
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    #   daemon.settings = {
    #     dns = ["8.8.8.8" "1.1.1.1"];
    #   };
    # };
    rootless.enable = false;
    enable = true; 
    daemon.settings = {
      dns = ["8.8.8.8" "1.1.1.1"];
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu = {
    opencl.enable = true;
    amdvlk.enable = true;
    amdvlk.support32Bit.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
#
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      pkgs.nerd-fonts.hack
    ];
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fraxx = {
    isNormalUser = true;
    description = "fraxx";
    extraGroups = [ "networkmanager" "wheel" "docker" "render" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kcolorchooser
    ];
    shell = pkgs.zsh;
  };

  programs.gamemode.enable = true;
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
        tmx = "/home/fraxx/dotfiles/scripts/tmux-sessions.sh";
        nixcfg = "sudo -E nvim /etc/nixos/configuration.nix";
        lg = "lazygit";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neofetch
    btop
    chromium
    gimp
    libreoffice
    discord
    tmux
    mangohud
    protonup
    xorg.xf86videoamdgpu
    nodejs_22
    git
    gcc
    curl
    wget
    unzip
    gnutar
    gzip
    neovim
    vimPlugins.lazy-nvim
    wl-clipboard
    kitty
    fzf
    gh
    lazygit
    zsh
    chatterino2
    kdePackages.kdenlive
    luajitPackages.luarocks_bootstrap
    ripgrep
    gcc
    gnumake
    brave
    docker_28
    code-cursor
    vscode
    # --- LSP ---
    lua-language-server
    nodePackages.typescript-language-server
    nodePackages.typescript
    tailwindcss-language-server
    emmet-ls
    svelte-language-server
    vscode-langservers-extracted
    # --- LSP ---
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 11434 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
