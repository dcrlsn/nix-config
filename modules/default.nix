{ lib, ... }:

let
  allNixFiles = lib.filesystem.listFilesRecursive ./.;
  moduleFiles = lib.filter (
    path:
    lib.hasSuffix ".nix" (toString path)
    && toString path != toString ./default.nix
  ) allNixFiles;
in
{
  imports = moduleFiles;
}
