{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # For Dual RTX 6000 PRO GPUs, you need to enable amd_iommu for tensor parallelism
  boot.kernelParams = [ "mitigations=off" "amd_iommu=on" "iommu=pt" ];

  # For more than one RTX PRO 6000 GPU, you need to explicitly enable P2P to maximize performance
  boot.extraModprobeConfig = ''
        options nvidia NVreg_RegistryDwords="ForceP2P=0x11;RMForceP2PType=1;RMPcieP2PType=2;GrdmaPciTopoCheckOverride=1;EnableResizableBar=1"
  '';

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      vllm = {
        image = "vllm/vllm-openai:cu130-nightly"; # Specify the image to use
        autoStart = false; # Ensures the container starts at boot (this is the default)
        volumes = [
          "/home/root/.cache/huggingface:/root/.cache/huggingface"
          "/home/root/.cache/vllm:/root/.cache/vllm"
        ];
        devices = [ "nvidia.com/gpu=all"];
        environment = {
          NCCL_P2P_LEVEL="4";
          NCCL_IB_DISABLE="1";
          OMP_NUM_THREADS="8";
          VLLM_SKIP_P2P_CHECK="1";
        };
        extraOptions = [
          "--ipc=host"
          "--shm-size=16g"
          "--network" "host"
          "--ulimit" "memlock=-1"
          "--ulimit" "stack=67108864"
        ];
        cmd = [
            "Sehyo/Qwen3.5-122B-A10B-NVFP4"
            "--host" "0.0.0.0"
            "--port" "8000"
            "--trust-remote-code"
            "--tensor-parallel-size" "2"
            "--language-model-only"
            "--max-model-len" "262144"
            "--gpu-memory-utilization" "0.95"
            "--kv-cache-dtype" "fp8"
            "--max-num-seqs" "16"
            "--max-num-batched-tokens" "4192"
            "--enable-prefix-caching"
            "--enable-chunked-prefill"
            "--enable-auto-tool-choice"
            "--tool-call-parser" "qwen3_coder"
            "--default-chat-template-kwargs" "{\"enable_thinking\": false}"
            "--speculative-config" "{\"method\": \"mtp\", \"num_speculative_tokens\": 1}"
            "--reasoning-parser" "qwen3"
            "--served-model-name" "Qwen35"
        ];
      };
    };
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     open-webui
     docker
  ];

  # enable open-webui for a chat ui
  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
  };

  # docker
  virtualisation.docker ={
    enable = true;
  };

  # direnv
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  # Nvidia specific configs
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia-container-toolkit.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
