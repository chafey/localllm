# localllm

My local llm setup - primarily used for software development with javascript

# Setup

Initialize git submodules which brings in [llm-inference-bench](https://github.com/voipmonitor/llm-inference-bench)
```sh
git submodule init
```

Enable direnv to load dependencies and configure python environment: (requires NIX)
```sh
direnv allow
```

# Hardware

* Learn about the [hardware](docs/HARDWARE.md)

# Software

## NIXOS

VLLM hangs with tensor parallelism unless you turn on amd_iommu=on via linux kernel params:
```nix
boot.kernelParams = [ "mitigations=off" "amd_iommu=on" "iommu=pt" ];
```

When running > 1 RTX 6000 Pro GPU, you need to force P2P on:
```nix
boot.extraModprobeConfig = ''
  options nvidia NVreg_RegistryDwords="ForceP2P=0x11;RMForceP2PType=1;RMPcieP2PType=2;GrdmaPciTopoCheckOverride=1;EnableResizableBar=1"
'';
```

* See [configuration.nix](configuration.nix) snippet


## VLLM via docker

* [Qwen3.5-122B (AWQ)](qwen3.5-122b-qt.sh) 190 tok/s
* [Qwen3.5-122B (NVFP4)](qwen3.5-122b.sh) 160 tok/s

## Benchmarking

```sh
cd llm-inference-bench
python3 llm_decode_bench.py --port 8000 --concurrency 1 --contexts 131072 --skip-prefill --duration 10
```

## Zed Editor

Configured agent panel to connect to vllm as an openai provider

```json
"language_models": {
    "openai_compatible": {
      "VLLM": {
        "api_url": "http://nixostr:8000/v1",
        "available_models": [
          {
            "name": "Qwen35",
            "max_tokens": 262144,
            "max_output_tokens": 32768,
            "max_completion_tokens": 16384,
            "capabilities": {
              "tools": true,
              "images": false,
              "parallel_tool_calls": true,
              "prompt_cache_key": true,
              "chat_completions": true,
            },
          },
        ],
      },
    },
  },
  ```

# More information

[RTX 6000 Pro Wiki](https://github.com/voipmonitor/rtx6kpro)
