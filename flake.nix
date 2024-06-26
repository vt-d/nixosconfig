{
  description = "Main NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim.url = "github:vt-d/nvim";

    # hypr
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprcursor.url = "github:hyprwm/hyprcursor";

    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {  nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    overlays = [
       inputs.neovim.overlays.x86_64-linux.neovim
    ];
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      pkgs = import nixpkgs { inherit system overlays; config = { allowUnfree = true; }; };
      modules = [
        ./hosts/default/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
