docker run -it --rm \
    --name vllm \
   --device nvidia.com/gpu=all \
    --ipc=host \
    --network host \
    -e NCCL_P2P_LEVEL=4 \
    -e NCCL_IB_DISABLE=1 \
    -e OMP_NUM_THREADS=8 \
    -e VLLM_SKIP_P2P_CHECK=1 \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    -v ~/.cache/vllm:/root/.cache/vllm \
    vllm/vllm-openai:cu130-nightly \
    lukealonso/MiniMax-M2.5-REAP-139B-A10B-NVFP4 \
    --port 8000 \
    --served-model-name Qwen35 \
    --trust-remote-code \
    --tensor-parallel-size 2 \
    --gpu-memory-utilization 0.95 \
    --max-model-len 190000 \
    --max-num-batched-tokens 16384 \
    --max-num-seqs 64 \
    --disable-custom-all-reduce \
    --enable-auto-tool-choice \
    --tool-call-parser minimax_m2 \
    --reasoning-parser minimax_m2
