# localllm
My local llm setup - primarily used for software development with javascript

# Hardware

* Learn about the [hardware](HARDWARE.md)

# Software

## NIXOS

boot.kernelParams = [ "mitigations=off" "amd_iommu=on" "iommu=pt" ];

NOTE: VLLM hangs with tensor parallelism unless you turn on amd_iommu=on

## VLLM via docker

* [Qwen3.5-122B](qwen3.5-122b.sh) 119 tgs

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
