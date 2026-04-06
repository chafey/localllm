docker run -it --rm \
  --entrypoint /bin/bash \
  --name sglang \
  --device nvidia.com/gpu=all \
  --ipc=host \
  --shm-size=8g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --network host \
  -e NCCL_P2P_LEVEL=4 \
  -e NCCL_IB_DISABLE=1 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -v ~/localllm:/workspace/localllm     \
  lmsysorg/sglang:dev-cu13
