docker run -it --rm \
  --name vllm \
  --device nvidia.com/gpu=all \
  --ipc=host \
  --shm-size=8g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --network host \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:cu130-nightly \
  Sehyo/Qwen3.5-122B-A10B-NVFP4 \
  --host 0.0.0.0 \
  --port 8000 \
  --tensor-parallel-size 2 \
  --gpu-memory-utilization 0.80 \
  --max-num-batched-tokens 4192 \
  --max-num-seqs 16 \
  --enable-prefix-caching \
  --enable-chunked-prefill \
  --async-scheduling \
  --language-model-only \
  --kv-cache-dtype fp8 \
  --trust-remote-code \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_coder \
  --reasoning-parser qwen3 \
  --default-chat-template-kwargs '{"enable_thinking": false}' \
  --speculative-config '{"method":"mtp","num_speculative_tokens":1}' \
  --served-model-name Qwen35
