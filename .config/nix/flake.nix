{
  description = "Example nix-darwin system flake";

  inputs = {
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
          pkgs.ripgrep
          pkgs.bat
          pkgs.fd
          pkgs.gdb
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      darwinConfigurations.macbook = {
          modules = [
              nix-homebrew.darwinModules.nix-homebrew
              {
                  nix-homebrew = {
                      enable = true;
                      enableRosetta = true;
                      user = "ohman";
                      autoMigrate = true;
                  };
              }
          ];
      }

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."lagom" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
