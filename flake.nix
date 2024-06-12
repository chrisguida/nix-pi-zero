{
  description = "nix-pi machine configuration";
#  inputs.nix-bitcoin.url = "github:chrisguida/nix-bitcoin/no-err-zero-feerate";
  inputs.nixpkgs.url = "github:chrisguida/nixpkgs/cguida/libxcrypt-dev-no-check";
  inputs.nix-bitcoin.url = "github:fort-nix/nix-bitcoin";
#  inputs.nixpkgs.follows = "nix-bitcoin/nixpkgs";
  outputs = { self, nix-bitcoin, nixpkgs }: {
    nixosConfigurations = {
      nix-pi = nix-bitcoin.inputs.nixpkgs.lib.nixosSystem {
        modules = [
          nix-bitcoin.nixosModules.default
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
          ./configuration.nix
        ];
      };
    };
    images = {
      nix-pi = self.nixosConfigurations.nix-pi.config.system.build.sdImage;
    };
  };
}

