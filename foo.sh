docker run --rm \
  --runtime nvidia \
  --gpus all \
  --ipc=host \
  --shm-size=16g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --network host \
  --volume ~/.cache/huggingface:/root/.cache/huggingface \
  --env OMP_NUM_THREADS=8 \
  --env VLLM_MEMORY_PROFILER_ESTIMATE_CUDAGRAPHS=1 \
  repne/vllm-openai \
  Qwen/Qwen3.6-35B-A3B-FP8 \
  --served-model-name Qwen3.5-35B-A3B \
  --tensor-parallel-size 1 \
  --gpu-memory-utilization 0.90 \
  --max-model-len 262144 \
  --max-num-seqs 32 \
  --max-num-batched-tokens 32758 \
  --block-size 32 \
  --language-model-only \
  -O3 \
  --enable-auto-tool-choice \
  --reasoning-parser qwen3 \
  --tool-call-parser qwen3_coder \
  --enable-prefix-caching \
  --speculative-config.method mtp \
  --speculative-config.num_speculative_tokens 3 \
  --speculative-config.rejection_sample_method probabilistic \
  --attention-backend flashinfer
