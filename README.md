# localllm

My local llm setup - primarily used for software development with javascript

[RTX 6000 Pro Wiki](https://github.com/voipmonitor/rtx6kpro)

# Hardware

* Learn about the [hardware](HARDWARE.md)

# Software

## NIXOS

boot.kernelParams = [ "mitigations=off" "amd_iommu=on" "iommu=pt" ];

boot.extraModprobeConfig = ''
  options nvidia NVreg_RegistryDwords="ForceP2P=0x11;RMForceP2PType=1;RMPcieP2PType=2;GrdmaPciTopoCheckOverride=1;EnableResizableBar=1"
'';

NOTE: VLLM hangs with tensor parallelism unless you turn on amd_iommu=on

## VLLM via docker

* [Qwen3.5-122B](qwen3.5-122b.sh) 132 tok/s

## Benchmarking

use [llm-inference-bench](https://github.com/voipmonitor/llm-inference-bench)

```
python3 llm_decode_bench.py --port 8000 --concurrency 1 --contexts 131072 --skip-prefill --duration 10
```

## Zed Editor

Configured agent panel to connect to vllm as an openai provider

```
"language_models": {
    "openai_compatible": {
      "VLLM": {
        "api_url": "http://nixostr:8000/v1",
        "available_models": [
          {
            "name": "Qwen35",
            "max_tokens": 262144,
            "max_output_tokens": 32000,
            "max_completion_tokens": 200000,
            "capabilities": {
              "tools": true,
              "images": false,
              "parallel_tool_calls": true,
              "prompt_cache_key": false,
              "chat_completions": true,
            },
          },
        ],
      },
    },
  },
  ```



NOTES
  --load-format fastsafetensors \
  -e NCCL_P2P_LEVEL=SYS=4 \
  -e NCCL_IB_DISABLE=1 \
  -e VLLM_WORKER_MULTIPROC_METHOD=spawn \
  --speculative-config '{"method":"mtp","num_speculative_tokens":1}' \
