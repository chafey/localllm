# localllm
My local llm setup

# Hardware

Motherboard: AMD sTR5 (ASUS PRO WS WRX90E-SAGE SE CEB)
 + 8 Channel DDR5
 + 6 PCIe 5.0 x16 slots (+ 1 PCIe 5.0 x8 slot)
 + 2x10GBE
 + IPMI

CPU: AMD Ryzen Threadripper PRO 9965WX 24-Cores
 + 272 GB/S Memory bandwidth (4 CCDs, 8 channel DDR5)
 + 128 PCIE 5.0 Lanes (16x PCIe 5.0 for each GPU)

CPU Cooler: Air Cooler (Arctic Freeer 4U-M)

RAM: 256GB DDR5 CL28 ECC (8x Kingston FURY Renegade Pro)

nVME: 4TB PCIe 5.0 (Crucial T705)

GPU: 2x96GB Blackwell (RTX PRO 6000 Blackwell Max-Q Workstation)
 + 300W power draw per GPU (vs 600W for the non Max-Q)
 + Blower fan makes it easier to cool
 + 192GB Total VRAM allows running larger models like Qwen3.5-122B

Power Supply: 2800 Watt HWPW(Super Flower Leadex Titanium 2800 Watt)
 + 4x12VHPWR connectors
 + Plenty of power for GPUs and ThreadRipper

Case: Cooler Master MasterFrame 700
 + Did initial build on this because it has lots of room, never migrated off of it

# Software

## NIXOS

boot.kernelParams = [ "mitigations=off" "amd_iommu=on" "iommu=pt" ];

NOTE: VLLM hangs with tensor parallelism unless you turn on amd_iommu=on

## VLLM via docker

```
docker run -it --rm \
  --name vllm \
  --env-file env.list \
  --device nvidia.com/gpu=all \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -p 8000:8000 \
  --ipc=host \
  vllm/vllm-openai:cu130-nightly \
  cyankiwi/Qwen3.5-27B-AWQ-4bit \
  --host 0.0.0.0 \
  --port 8000 \
  --trust-remote-code \
  --language-model-only \
  --served-model-name Qwen35 \
  --enable-prefix-caching \
  --kv-cache-dtype fp8 \
  --enable-auto-tool-choice \
  --reasoning-parser qwen3 \
  --default-chat-template-kwargs '{"enable_thinking": false}' \
  --speculative-config '{"method":"mtp","num_speculative_tokens":1}' \
  --tool-call-parser qwen3_coder
```

## env.list

NOTE: no env variables are currently being used (all are commented out)

```
#VLLM_MOE_FORCE_MARLIN=1
#VLLM_SLEEP_WHEN_IDLE=1
#NCCL_P2P_DISABLE=1
#VLLM_SKIP_P2P_CHECK=1
#CUDA_VISIBLE_DEVICES=0,1
```
