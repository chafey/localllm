docker run -it --rm \
  --name vllm \
  --device nvidia.com/gpu=all \
  --ipc=host \
  --shm-size=16g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --network host \
  -e NCCL_P2P_LEVEL=4 \
  -e NCCL_IB_DISABLE=1 \
  -e OMP_NUM_THREADS=8 \
  -e VLLM_SKIP_P2P_CHECK=1 \
  -e VLLM_ALLOW_LONG_MAX_MODEL_LEN=1 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -v ~/.cache/vllm:/root/.cache/vllm \
  vllm/vllm-openai:v0.19.1-cu130 \
  RedHatAI/Qwen3.6-35B-A3B-NVFP4 \
  --host 0.0.0.0 \
  --port 8000 \
  --max-model-len 262144 \
  --reasoning-parser qwen3 \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_coder \
  --enable-prefix-caching \
  --enable-chunked-prefill \
  --trust-remote-code \
  --max-num-seqs 1 \
  --max-num-batched-tokens 12672 \
  --gpu-memory-utilization 0.95 \
  --kv-cache-dtype fp8 \
  --moe_backend flashinfer_cutlass  \
  --language-model-only \
  --served-model-name Qwen35

#  --tensor-parallel-size 1
