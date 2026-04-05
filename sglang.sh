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
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -v ~/.cache/vllm:/root/.cache/vllm \
  lmsysorg/sglang:dev-cu13 \
  bash
