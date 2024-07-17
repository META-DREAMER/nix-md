to install:

```shell
passwd
nix-shell -p git
git clone https://github.com/META-DREAMER/nix-md.git
nix run github:nix-community/nixos-anywhere --extra-experimental-features "nix-command flakes" -- --flake '.#ghazali' nixos@<ipaddress>
```

disko install:

```shell
sudo nix run 'github:nix-community/disko#disko-install' --extra-experimental-features "nix-command flakes"  --  --write-efi-boot-entries --flake '.#ghazali' --disk disk1 /dev/nvme1n1
```