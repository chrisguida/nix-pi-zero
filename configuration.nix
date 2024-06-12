# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }: {
  networking.hostName = "nix-pi";
  time.timeZone = "UTC";

  services.openssh = {
    enable = true;
  };
  users.users.root = {
    openssh.authorizedKeys.keys = [
      # FIXME: Replace this with your SSH pubkey
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAyg23mUQq55zHvcjo+F8bVXDQ33b4uIhiYU99V3lX1 cguida@cg-acer"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEQjOgrgPaeaCAMMgNpjayLgj6EPC4m32MSCklYyYsuU cguida@cg-lenovo"
    ];
  };
  nix.extraOptions = "experimental-features = nix-command flakes";

  system.stateVersion = "23.11"; # Did you read the comment?
  nixpkgs.hostPlatform = lib.mkDefault "armv6l-linux";
  nix-bitcoin.generateSecrets = true;
  nixpkgs.overlays = [
    (self: super: {
      libxcrypt = super.libxcrypt.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];
}
