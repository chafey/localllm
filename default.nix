# save this as default.nix
{ pkgs ? import <nixpkgs> {}}:


pkgs.mkShell {
  packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.venvShellHook
    cudaPackages.cuda_nvcc
    cudaPackages.cuda_cudart
    cudaPackages.nccl
  ];
  venvDir = "./.venv";
  postShellHook = ''
    echo "Hook running!"

    export CUDA_PATH=${pkgs.cudatoolkit}
    # Link to the system NVIDIA drivers for runtime
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/run/opengl-driver/lib

    source .venv/bin/activate
    pip install httpx rich
  '';
}
