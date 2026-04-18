# save this as default.nix
{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.venvShellHook
  ];
  venvDir = "./.venv";
  postShellHook = ''
    echo "Hook running!"
    source .venv/bin/activate
    pip install httpx rich
  '';
}
